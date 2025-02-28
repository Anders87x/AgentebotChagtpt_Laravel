<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use OpenAI;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ChatController extends Controller
{
    public function ask(Request $request)
    {
        $userMessage = $request->input('message');

        if (!$userMessage) {
            return response()->json(['response' => 'Por favor, escribe una pregunta.']);
        }

        try {
            $client = OpenAI::client(env('OPENAI_API_KEY'));

            // Prompt mejorado para que ChatGPT devuelva CONSULTAS VÁLIDAS en Laravel
            $prompt = "
                Actúas como un asistente virtual experto en Laravel Eloquent. 
                
                - Si el usuario pregunta sobre información en la base de datos, 
                  traduce su pregunta a una consulta en Laravel Eloquent en UNA sola línea. 
                - No devuelvas explicaciones ni comentarios, solo el código.  
                - No inventes datos, solo genera la consulta.

                Equivalencias de nombres de tablas en español a modelos:
                'clientes', 'cliente' → App\Models\Client
                'proveedores', 'proveedor' → App\Models\Supplier
                'ventas', 'venta' → App\Models\Sale
                'compras', 'compra' → App\Models\Purchase
                'usuarios', 'usuario' → App\Models\User
                'sucursales', 'sucursal' → App\Models\Branch
                'conversaciones', 'historial' → App\Models\Conversation

                Pregunta del usuario: $userMessage
            ";

            // Enviar la solicitud a ChatGPT
            $response = $client->chat()->create([
                'model' => 'gpt-3.5-turbo',
                'messages' => [['role' => 'system', 'content' => $prompt]],
                'max_tokens' => 150,
            ]);

            $query = trim($response['choices'][0]['message']['content'] ?? '');

            // Log para depuración
            Log::info("Consulta Generada por ChatGPT: " . $query);

            // Si la respuesta contiene una consulta válida, ejecutarla
            if (str_contains($query, "DB::") || str_contains($query, "App\\Models\\")) {
                try {
                    $result = eval("return $query;");

                    // Convertir el resultado en lenguaje natural
                    if (is_numeric($result)) {
                        return response()->json(['response' => "El resultado es: $result."]);
                    } elseif (is_array($result) || is_object($result)) {
                        return response()->json(['response' => "Aquí están los datos:\n\n" . json_encode($result, JSON_PRETTY_PRINT)]);
                    } else {
                        return response()->json(['response' => "Aquí tienes la información solicitada: $result"]);
                    }
                } catch (\Exception $e) {
                    return response()->json(['response' => 'Hubo un error al procesar la consulta.']);
                }
            }

            // Si no es una consulta, devolver la respuesta directamente
            return response()->json(['response' => $query]);

        } catch (\Exception $e) {
            return response()->json(['response' => 'Error al conectar con OpenAI: ' . $e->getMessage()]);
        }
    }
}
