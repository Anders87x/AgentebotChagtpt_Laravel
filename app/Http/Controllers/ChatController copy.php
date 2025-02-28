<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use OpenAI;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Models\Client;
use App\Models\Supplier;
use App\Models\Sale;
use App\Models\Purchase;
use App\Models\User;
use App\Models\Branch;
use App\Models\Conversation;

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

            // Prompt actualizado para generar consultas en Laravel Eloquent
            $prompt = "
                Actúas como un asistente experto en Laravel.
                
                - Cuando el usuario haga una pregunta sobre la base de datos, genera SOLO la consulta en Laravel Eloquent usando el namespace completo de los modelos.
                - Usa la estructura correcta:

                - Tabla 'clients' → Modelo: App\Models\Client
                - Tabla 'suppliers' → Modelo: App\Models\Supplier
                - Tabla 'sales' → Modelo: App\Models\Sale
                - Tabla 'purchases' → Modelo: App\Models\Purchase
                - Tabla 'users' → Modelo: App\Models\User
                - Tabla 'branches' → Modelo: App\Models\Branch
                - Tabla 'conversations' → Modelo: App\Models\Conversation

                - Si la consulta es sobre ventas, usa `sales.client_id`.
                - Si la consulta es sobre compras, usa `purchases.supplier_id`.
                - Si la consulta usa `amount`, cámbialo por `total` en `sales`.
                - Si la consulta involucra relaciones, usa `with()`, `groupBy()`, `orderByDesc()`, `whereMonth()` y `whereYear()` correctamente.
                - Devuelve la consulta en una sola línea, sin explicaciones, sin comentarios y SIN comillas invertidas (`).
                - No uses `DB::table()`, solo modelos de Laravel.
                - No inventes datos, solo genera la consulta correcta.

                Pregunta del usuario: $userMessage
            ";

            // Enviar la consulta a OpenAI
            $response = $client->chat()->create([
                'model' => 'gpt-4-turbo',
                'messages' => [['role' => 'system', 'content' => $prompt]],
                'max_tokens' => 100,
            ]);

            // Obtener la consulta generada
            $query = trim($response['choices'][0]['message']['content'] ?? '');

            // LOG PARA DEPURACIÓN - Ver la consulta generada por ChatGPT
            Log::info("Consulta Generada por ChatGPT: " . $query);

            // **LIMPIEZA MÁS RIGUROSA**
            $query = str_replace(['`', '<?php', '?>', '```php', '```', 'php'], '', $query);
            $query = trim($query); // Eliminar espacios extra

            // **CORRECCIÓN DE FORMATO**
            // Si la consulta comienza con `\App\Models\`, eliminamos la barra invertida
            if (str_starts_with($query, '\App\Models\\')) {
                $query = substr($query, 1);
            }

            // LOG PARA DEPURACIÓN - Ver consulta después de limpieza
            Log::info("Consulta después de limpieza: " . $query);

            // **CORRECCIÓN AUTOMÁTICA**
            if (str_contains($query, 'App\Models\Sale') && str_contains($query, 'amount')) {
                $query = str_replace('amount', 'total', $query);
                Log::info("Corrección: Se cambió `amount` por `total` en `sales`.");
            }

            // **Validación de seguridad**
            // Permitimos solo los siguientes modelos
            $allowedModels = ['Client', 'Supplier', 'Sale', 'Purchase', 'User', 'Branch', 'Conversation'];

            // Ahora permitimos consultas más avanzadas
            $allowedMethods = [
                'count', 'sum', 'get', 'first', 'select', 'where', 'whereBetween', 'whereMonth', 'whereYear',
                'limit', 'pluck', 'with', 'selectRaw', 'groupBy', 'orderByDesc'
            ];

            // Extraemos el modelo y método de la consulta
            if (preg_match('/^App\\\Models\\\(.*?)::(.*?)\(/', $query, $matches)) {
                $model = $matches[1]; // Ejemplo: "Client"
                $method = $matches[2]; // Ejemplo: "count"

                // LOG PARA DEPURACIÓN - Ver modelo y método extraídos
                Log::info("Modelo extraído: " . $model);
                Log::info("Método extraído: " . $method);

                // Verificamos si el modelo y método están permitidos
                if (!in_array($model, $allowedModels) || !in_array($method, $allowedMethods)) {
                    Log::error("Consulta no permitida: Modelo o método no válido.");
                    return response()->json(['response' => 'Error: Consulta no permitida.']);
                }

                // **CORREGIR CONSULTAS CON `where()`**
                if ($method === 'where') {
                    // Detectamos si se está usando `first(['campo'])` incorrectamente
                    if (preg_match("/first\(\[(.*?)\]\)/", $query, $fieldMatch)) {
                        $field = trim(str_replace("'", "", $fieldMatch[1])); // Extraemos el campo
                        $query = str_replace("first(['$field'])", "pluck('$field')->first()", $query);
                    }
                }

                // LOG PARA DEPURACIÓN - Consulta corregida
                Log::info("Consulta después de corrección: " . $query);

                try {
                    // **Ejecutamos la consulta**
                    Log::info("Ejecutando consulta: " . $query);
                    $result = eval("return $query;");
                    // **$result = call_user_func([$modelClass, $method]); **

                    // LOG PARA DEPURACIÓN - Ver resultado de la consulta
                    Log::info("Resultado de la consulta: " . json_encode($result));

                    // Convertimos la respuesta en lenguaje natural
                    if (is_numeric($result)) {
                        return response()->json(['response' => "El resultado es: $result."]);
                    } elseif (is_array($result) || is_object($result)) {
                        return response()->json(['response' => "Aquí tienes los datos:\n\n" . json_encode($result, JSON_PRETTY_PRINT)]);
                    } else {
                        return response()->json(['response' => "Aquí tienes la información solicitada: $result"]);
                    }

                } catch (\Exception $e) {
                    Log::error("Error al ejecutar la consulta: " . $e->getMessage());
                    return response()->json(['response' => 'Hubo un error al procesar la consulta.']);
                }
            }

            Log::error("No se pudo interpretar la consulta.");
            return response()->json(['response' => 'Error: No se pudo interpretar la consulta.']);

        } catch (\Exception $e) {
            Log::error("Error al conectar con OpenAI: " . $e->getMessage());
            return response()->json(['response' => 'Error al conectar con OpenAI: ' . $e->getMessage()]);
        }
    }
}
