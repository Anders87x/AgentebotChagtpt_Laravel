<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChatMessage extends Model
{
    use HasFactory;

    protected $fillable = ['chat_id', 'message', 'sender'];

    public function chat()
    {
        return $this->belongsTo(Chat::class);
    }
}
