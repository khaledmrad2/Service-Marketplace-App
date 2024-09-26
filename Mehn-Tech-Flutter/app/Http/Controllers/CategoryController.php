<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\WorkShop;
use App\Models\User;
use App\Models\Order;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::all();

        return response()->json($categories);
    }

    public function updateloction(Request $request)
    {
        // Retrieve the name data from the request
        $type = $request->input('type');
        $id = $request->input('id');
        $location = $request->input('location');

        // Perform the update operation based on the user type and ID
        if ($type == 0) {
            $user = User::find($id);
        } elseif ($type == 1) {
            $user = WorkShop::find($id);
        } else {
            // Handle invalid user type error
            return response()->json(['error' => 'Invalid user type'], 400);
        }
        // Check if the user exists
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Update the name
        $user->location = $location;
        $user->save();

        // Return a success response
        return response()->json(['message' => 'Name updated successfully'], 200);
    }

    public function getworkshop_res(Request $request)
    {
        // Retrieve the category ID and location name from the query parameters
        $categoryId = $request->query('category_id');
        $locationName = $request->query('location');
        // Query the workshops based on the category ID and location name
        $workshops = Workshop::where('category_id', $categoryId)
            ->where('location', $locationName)
            ->get();

        // Return the workshops as a JSON response
        return response()->json($workshops, 200);
    }


    public function store_order(Request $request)
    {

        $order = Order::create($request->all());
        // Return a response
        return response()->json([
            $order,
        ], 201);
    }

    public function my_order(Request $request)
    {

        $id = $request->query('id');
        $type = $request->query('type');
        $column = ($type == 0) ? 'user_id' : 'workshop_id';
        $data =($type == 1) ? 'user' : 'workshop';
        $orders = Order::where($column, $id)->with($data)->get();

        // Return the orders in the response
        return response()->json([
            $orders,
        ], 200);
    }
    public function update_order_status($orderId)
    {
        $newStatus = request()->input('status');
        $newCost = request()->input('cost');

        $order = Order::find($orderId);
        if (!$order) {
            return response()->json(['error' => 'Order not found'], 404);
        }
        $order->status = $newStatus;
        if($newCost){
            $order->cost = $newCost;
        }
        $order->save();

        return response()->json(['message' => 'Order status updated successfully'],200);
    }

    public function search(Request $request)
    {
        $keyword = $request->query('name');
        $workshops = Workshop::where('name', 'LIKE', '%' . $keyword . '%')->get();
        return response()->json([$workshops], 200);
    }

}
