<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;
use Laravel\Passport\HasApiTokens;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Support\Facades\Hash;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Workshop;
use App\Models\Category;
use App\Models\Service;

class AuthController extends Controller
{

    public function register(Request $request)
    {
        $type = $request->input('type');

        if ($type == 1) {

        // Registering a workshop
        $email = $request->input('email');
        $password = $request->input('password');

        // Check if the email is already used for a workshop
        $existingWorkshop = Workshop::where('email', $email)->first();
        if ($existingWorkshop) {
            return response()->json(['error' => 'Email already exists'], 409);
        }
            // Registering a workshop
            $workshop = Workshop::create([
                'name' => $request->input('name'),
                'phone' => $request->input('phone'),
                'location' => $request->input('location'),
                'email' => $request->input('email'),
                'password' => bcrypt($request->input('password')),
                'category_id' => $request->input('category_id'),
            ]);
            $token = $email.$password;
            $workshop->remember_token=$token;
            // Attach services to the workshop
           // $serviceIds = $request->input('service_ids', []);

            return response()->json(['message' => 'Workshop registered successfully'], 201);
        } elseif ($type == 0) {
            $email = $request->input('email');

            // Check if the email is already used
            $existingUser = User::where('email', $email)->first();

            if ($existingUser) {
                return response()->json(['error' => 'Email already exists'], 409);
            }
            // Registering a user
            $user = User::create([
                'name' => $request->input('name'),
                'email' => $request->input('email'),
                'phone' => $request->input('phone'),
                'location' => $request->input('location'),
                'password' => bcrypt($request->input('password')),
            ]);

            return response()->json(['message' => 'User registered successfully'], 201);
        } else {
            return response()->json(['error' => 'Invalid type'], 400);
        }
    }

    public function login(Request $request)
    {
        $email = $request->input('email');
        $password = $request->input('password');

        // Check if the email and password belong to a User
        $user = User::where('email', $email)->first();
        if ($user && Hash::check($password, $user->password)) {
            $type = 0; // User type
            $data = $user; // User data
            $email = $request->input('email');
            $password = $request->input('password');
            $token = $email.$password;
            return response()->json([
                'type' => $type,
                'user' => $user,
                'token' => $token,
            ],201);
        }

        // Check if the email and password belong to a Workshop
        $workshop = Workshop::where('email', $email)->first();
        if ($workshop && Hash::check($password, $workshop->password)) {
            $type = 1; // Workshop type
            $data = $workshop; // Workshop data
            $token = $email.$password;

            return response()->json([
              'type' => $type,
              'user' => $workshop,
              'token' => $token,
            ],201);
        }

        return response()->json(['error' => 'Invalid credentials'], 401);
    }
}
