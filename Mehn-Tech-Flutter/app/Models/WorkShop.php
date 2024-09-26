<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WorkShop extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'phone', 'location', 'email', 'password','category_id',
    ];

    // public function services()
    // {
    //     return $this->belongsToMany(Service::class, 'workshop_service');
    // }
}

