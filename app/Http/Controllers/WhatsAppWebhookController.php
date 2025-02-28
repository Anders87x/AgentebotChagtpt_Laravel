<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Log;
use App\Models\Chat;
use App\Models\ChatMessage;

class WhatsAppWebhookController extends Controller
{
    // **1️⃣ Verificación del Webhook (Meta nos enviará un challenge)**
    public function verify(Request $request)
    {
        $verifyToken = env('WHATSAPP_VERIFY_TOKEN'); // Token de verificación en .env

        if ($request->hub_mode === 'subscribe' && $request->hub_verify_token === $verifyToken) {
            return response($request->hub_challenge, 200);
        }

        return response('No autorizado', 403);
    }

    // **2️⃣ Recibir y procesar mensajes de WhatsApp**
    public function receive(Request $request)
    {
        // **Guardar el evento recibido en logs para depuración**
        CustomLogger::log('info', "Evento de WhatsApp recibido: ", ['query' => json_encode($request->all())]);

        // **Verificar si el evento contiene un mensaje**
        if (!isset($request['entry'][0]['changes'][0]['value']['messages'])) {
            return response()->json(['message' => 'No hay mensajes.'], 200);
        }

        $messageData = $request['entry'][0]['changes'][0]['value']['messages'][0];

        // **Extraer información del mensaje**
        $whatsappNumber = $request['entry'][0]['changes'][0]['value']['contacts'][0]['wa_id'];
        $userMessage = $messageData['text']['body'] ?? '';

        // **Verificar si el chat ya existe, sino crearlo**
        $chat = Chat::firstOrCreate(
            ['whatsapp_number' => $whatsappNumber],
            ['name' => 'Usuario WhatsApp']
        );

        // **Guardar el mensaje del usuario**
        ChatMessage::create([
            'chat_id' => $chat->id,
            'message' => $userMessage,
            'sender' => 'user',
        ]);

        // **Llamar al bot para generar la respuesta**
        $botResponse = $this->getBotResponse($userMessage);

        // **Guardar la respuesta del bot**
        ChatMessage::create([
            'chat_id' => $chat->id,
            'message' => $botResponse,
            'sender' => 'agent',
        ]);

        // **Enviar la respuesta al usuario vía WhatsApp API**
        $this->sendWhatsAppMessage($whatsappNumber, $botResponse);

        return response()->json(['message' => 'Mensaje procesado'], 200);
    }

    // **3️⃣ Generar Respuesta del Bot Usando ChatGPT**
    private function getBotResponse($userMessage)
    {
        // Puedes reutilizar la lógica del bot que hicimos antes
        return "Gracias por tu mensaje, estamos procesando tu solicitud.";
    }

    // **4️⃣ Enviar Mensaje a WhatsApp a través de Meta API**
    private function sendWhatsAppMessage($to, $message)
    {
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

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $response = curl_exec($ch);
        curl_close($ch);

        CustomLogger::log('info', "Respuesta de WhatsApp API: ", ['query' => $response]);
    }
}
