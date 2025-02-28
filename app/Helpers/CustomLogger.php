<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Log;

class CustomLogger
{
    public static function log($level, $message, $context = [])
    {
        // Convertimos el contexto a JSON si no está vacío
        $contextJson = !empty($context) ? json_encode($context) : null;

        // Guardamos en el log de Laravel
        Log::$level($message, $context);

        // Si tienes una tabla de logs en la BD, puedes usar esto:
        \DB::table('logs')->insert([
            'level' => $level,
            'message' => $message,
            'context' => $contextJson,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}