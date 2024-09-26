<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'cat_id', 'pic_id', 'description',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'cat_id');
        
    }

    public function workshops()
    {
        return $this->belongsToMany(WorkShop::class, 'workshop_service');
    }
}
