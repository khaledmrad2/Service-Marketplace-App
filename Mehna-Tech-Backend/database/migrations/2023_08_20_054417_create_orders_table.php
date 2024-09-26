<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('workshop_id');
            $table->unsignedBigInteger('user_id');
            $table->text('description');
            $table->string('date');
            $table->string('cost')->nullable()->default(0);
            $table->integer('status')->default(0);
            $table->timestamps();
            $table->foreign('workshop_id')->references('id')->on('work_shops');
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
