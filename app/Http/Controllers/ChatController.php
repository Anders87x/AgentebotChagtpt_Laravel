<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use OpenAI;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use App\Models\Product;
use App\Models\Chat;
use App\Models\ChatMessage;

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

            // **Obtenemos o creamos el chat con los datos en duro**
            $chat = Chat::firstOrCreate(
                ['whatsapp_number' => '51999999999'], // Si ya existe, lo obtiene
                ['name' => 'AnderCode Pruebas']
            );

            // **Guardamos el mensaje del usuario**
            ChatMessage::create([
                'chat_id' => $chat->id,
                'message' => $userMessage,
                'sender' => 'user',
            ]);

            // **Prompt mejorado**
            $prompt = "
                Actúas como un asistente de ventas para la tienda en línea de Andercode.
                Solo generarás consultas en Laravel Eloquent usando el namespace completo `App\Models\Product`.

                📌 **Estructura de la tabla `products`:**
                - `id`, `name`, `description`, `image`, `video`, `location`
                - `stock`, `price`, `discount_price`, `currency`, `category`, `sku`, `active`

                🔹 **Ejemplo de preguntas y consultas correctas en Laravel:**
                - ❓ ¿Cuántos productos hay en stock?
                  ✅ `App\Models\Product::sum('stock');`

                - ❓ ¿Cuánto cuesta el iPhone 14 Pro Max?
                  ✅ `App\Models\Product::where('name', 'iPhone 14 Pro Max')->value('price');`

                - ❓ ¿Cuáles son los productos en oferta?
                  ✅ `App\Models\Product::whereNotNull('discount_price')->get(['name', 'discount_price']);`

                - ❓ ¿Qué categorías de productos hay?
                  ✅ `App\Models\Product::distinct()->pluck('category');`

                - ❓ ¿Cuál es el precio con descuento del producto 'Sed Cum Debitis'?
                  ✅ `App\Models\Product::where('name', 'Sed Cum Debitis')->value('discount_price');`

                **Devuelve SOLO la consulta en una línea de código Laravel Eloquent, sin explicaciones, sin comentarios, sin etiquetas de código como `plaintext`, `php` o ```**.

                Pregunta del usuario: $userMessage
            ";

            // **Enviar la consulta a OpenAI**
            $response = $client->chat()->create([
                'model' => 'gpt-4-turbo',
                'messages' => [['role' => 'system', 'content' => $prompt]],
                'max_tokens' => 100,
            ]);

            // **Obtener la consulta generada**
            $query = trim($response['choices'][0]['message']['content'] ?? '');
            Log::info("Consulta Generada por ChatGPT: " . $query);

            // **LIMPIEZA DEL CÓDIGO**
            $query = str_replace(['`', '<?php', '?>', '```php', '```', 'plaintext', 'php'], '', $query);
            $query = trim($query);

            // **Validación de seguridad**
            $allowedMethods = ['count', 'sum', 'get', 'first', 'select', 'where', 'whereBetween', 'whereMonth', 'whereYear', 'value', 'pluck', 'with', 'selectRaw', 'groupBy', 'orderByDesc'];

            if (preg_match('/^App\\\Models\\\Product::(.*?)\(/', $query, $matches)) {
                $method = $matches[1];

                // LOG PARA DEPURACIÓN - Ver método extraído
                Log::info("Método extraído: " . $method);

                if (!in_array($method, $allowedMethods)) {
                    Log::error("Consulta no permitida: Método no válido.");
                    return response()->json(['response' => 'Error: Consulta no permitida.']);
                }

                // **Ejecutar la consulta en la BD**
                try {
                    Log::info("Ejecutando consulta: " . $query);
                    $result = eval("return $query;");

                    Log::info("Resultado de la consulta: " . json_encode($result));

                    // **Convertimos el resultado en lenguaje natural**
                    if (!$result) {
                        $responseText = "No se encontraron resultados para tu consulta.";
                    } elseif (is_numeric($result)) {
                        $responseText = "El resultado es: $result.";
                    } elseif (is_array($result) || is_object($result)) {
                        $responseText = "Aquí tienes los datos:\n\n" . json_encode($result, JSON_PRETTY_PRINT);
                    } else {
                        $responseText = "Aquí tienes la información solicitada: $result";
                    }

                    // **Guardamos la respuesta del bot**
                    ChatMessage::create([
                        'chat_id' => $chat->id,
                        'message' => $responseText,
                        'sender' => 'agent',
                    ]);

                    return response()->json(['response' => $responseText]);

                } catch (\Exception $e) {
                    Log::error("Error al ejecutar la consulta: " . $e->getMessage());
                    return response()->json(['response' => 'Hubo un error al procesar la consulta.']);
                }
            }

            Log::error("Consulta no válida.");
            return response()->json(['response' => 'Error: No se pudo interpretar la consulta.']);

        } catch (\Exception $e) {
            Log::error("Error al conectar con OpenAI: " . $e->getMessage());
            return response()->json(['response' => 'Error al conectar con OpenAI: ' . $e->getMessage()]);
        }
    }
}
