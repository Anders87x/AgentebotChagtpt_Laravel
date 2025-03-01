<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Helpers\CustomLogger;
use App\Models\Chat;
use App\Models\ChatMessage;

class WhatsAppWebhookController extends Controller
{
    // **1️⃣ Verificación del Webhook (Meta nos enviará un challenge)**
    public function verify(Request $request)
    {
        CustomLogger::log('info', 'Verificación del Webhook iniciada.', ['query' => json_encode($request->all())]);

        $verifyToken = env('WHATSAPP_VERIFY_TOKEN'); // Token de verificación en .env

        if ($request->hub_mode === 'subscribe' && $request->hub_verify_token === $verifyToken) {
            CustomLogger::log('info', 'Webhook verificado correctamente.');
            return response($request->hub_challenge, 200);
        }

        CustomLogger::log('error', 'Fallo en la verificación del Webhook.');
        return response('No autorizado', 403);
    }

    // **2️⃣ Recibir y procesar mensajes de WhatsApp**
    public function receive(Request $request)
    {
        try {
            // **Guardar el evento recibido en logs para depuración**
            CustomLogger::log('info', "Evento de WhatsApp recibido.", ['query' => json_encode($request->all())]);

            // **Verificar si el evento contiene un mensaje**
            if (!isset($request['entry'][0]['changes'][0]['value']['messages'])) {
                CustomLogger::log('warning', "No se encontraron mensajes en el evento recibido.");
                return response()->json(['message' => 'No hay mensajes.'], 200);
            }

            $messageData = $request['entry'][0]['changes'][0]['value']['messages'][0] ?? null;
            $whatsappNumber = $request['entry'][0]['changes'][0]['value']['contacts'][0]['wa_id'] ?? null;
            $userName = $request['entry'][0]['changes'][0]['value']['contacts'][0]['profile']['name'] ?? 'Usuario WhatsApp';
            $userMessage = $messageData['text']['body'] ?? '';

            // **Verificar si los datos esenciales existen**
            if (!$whatsappNumber || !$userMessage) {
                CustomLogger::log('error', "Número de WhatsApp o mensaje no encontrado.", ['data' => json_encode($messageData)]);
                return response()->json(['message' => 'Error en los datos recibidos.'], 400);
            }

            // **Verificar si el chat ya existe, sino crearlo**
            $chat = Chat::firstOrCreate(
                ['whatsapp_number' => $whatsappNumber],
                ['name' => $userName] // ✅ Guardamos el nombre del usuario de WhatsApp
            );

            CustomLogger::log('info', "Chat verificado o creado.", ['chat_id' => $chat->id]);

            // **Guardar el mensaje del usuario**
            ChatMessage::create([
                'chat_id' => $chat->id,
                'message' => $userMessage,
                'sender' => 'user',
            ]);

            CustomLogger::log('info', "Mensaje del usuario guardado en la BD.", ['chat_id' => $chat->id, 'message' => $userMessage]);

            // **Llamar al bot para generar la respuesta**
            $botResponse = $this->getBotResponse($userMessage);

            // **Guardar la respuesta del bot**
            ChatMessage::create([
                'chat_id' => $chat->id,
                'message' => $botResponse,
                'sender' => 'agent',
            ]);

            CustomLogger::log('info', "Respuesta del bot guardada en la BD.", ['chat_id' => $chat->id, 'message' => $botResponse]);

            // **Enviar la respuesta al usuario vía WhatsApp API**
            $this->sendWhatsAppMessage($whatsappNumber, "Hola, soy tu asistente virtual. ¿En qué puedo ayudarte?");

            return response()->json(['message' => 'Mensaje procesado'], 200);
        } catch (\Exception $e) {
            CustomLogger::log('error', "Error en la recepción de mensaje.", ['exception' => $e->getMessage()]);
            return response()->json(['message' => 'Error interno del servidor.'], 500);
        }
    }

    // **3️⃣ Generar Respuesta del Bot Usando ChatGPT**
    private function getBotResponse($userMessage)
    {
        CustomLogger::log('info', "Generando respuesta del bot.", ['user_message' => $userMessage]);

        // Simulación de respuesta, puedes reemplazarlo con integración a ChatGPT
        return "Gracias por tu mensaje, estamos procesando tu solicitud.";
    }

    // **4️⃣ Enviar Mensaje a WhatsApp a través de Meta API**
    private function sendWhatsAppMessage($to, $message)
    {
        try {
            $accessToken = env('WHATSAPP_ACCESS_TOKEN'); // Token de Meta en .env
            $phoneNumberId = env('WHATSAPP_PHONE_ID'); // Número de WhatsApp en Meta

            $url = "https://graph.facebook.com/v22.0/{$phoneNumberId}/messages";

            $data = [
                "messaging_product" => "whatsapp",
                "to" => $to,
                "text" => ["body" => $message],
            ];

            $headers = [
                "Authorization: Bearer $accessToken",
                "Content-Type: application/json"
            ];

            CustomLogger::log('info', "Enviando mensaje a WhatsApp API.", ['to' => $to, 'message' => $message]);

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

            $response = curl_exec($ch);
            curl_close($ch);

            CustomLogger::log('info', "Respuesta de WhatsApp API recibida.", ['response' => $response]);

        } catch (\Exception $e) {
            CustomLogger::log('error', "Error al enviar mensaje a WhatsApp API.", ['exception' => $e->getMessage()]);
        }
    }
}