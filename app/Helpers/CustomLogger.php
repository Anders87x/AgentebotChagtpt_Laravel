namespace App\Helpers;

<?php
use App\Models\LogEntry;

class CustomLogger
{
    public static function log($level, $message, $context = [])
    {
        LogEntry::create([
            'level' => $level,
            'message' => $message,
            'context' => json_encode($context),
        ]);
    }
}
