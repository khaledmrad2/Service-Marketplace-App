<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);



Route::get('/p', [CategoryController::class, 'index']);
Route::put('/location', [CategoryController::class, 'updateloction']);
Route::get('/result', [CategoryController::class, 'getworkshop_res']);
Route::get('/workshops/search', [CategoryController::class, 'search']);

///Orders
Route::post('/create_orders', [CategoryController::class, 'store_order']);
Route::get('/my_order', [CategoryController::class, 'my_order']);
Route::put('/orders/{orderId}/status',[CategoryController::class, 'update_order_status']);


// Route::get('/categories', [CategoryController::class, 'index']);
// Route::put('/location', [CategoryController::class, 'updateloction']);
// Route::get('/result', [CategoryController::class, 'getworkshop_res']);
// Route::get('/workshops/search', [CategoryController::class, 'search']);

