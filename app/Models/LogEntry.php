<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LogEntry extends Model
{
    use HasFactory;

    protected $table = 'logs'; 

    protected $fillable = ['level', 'message', 'context'];

    protected $casts = [
        'context' => 'array', // Convierte JSON a array automáticamente
    ];
}
