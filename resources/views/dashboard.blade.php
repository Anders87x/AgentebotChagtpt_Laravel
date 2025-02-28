<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">

                <!-- Título -->
                <h2 class="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-4">
                    Chat con el Agente IA
                </h2>

                <!-- Contenedor de Mensajes -->
                <div id="chat-container" class="h-96 overflow-y-auto border rounded-lg p-4 bg-gray-100 dark:bg-gray-700">
                    <div id="messages" class="space-y-4">
                        <!-- Aquí se agregarán los mensajes dinámicamente -->
                    </div>
                </div>

                <!-- Entrada de Usuario -->
                <div class="mt-4">
                    <textarea id="user-message" class="w-full p-2 border rounded-lg bg-gray-50 dark:bg-gray-800 dark:text-white"
                        rows="3" placeholder="Escribe tu pregunta..."></textarea>
                </div>

                <!-- Botón de Enviar -->
                <div class="mt-2 flex justify-end">
                    <button id="send-message" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                        Enviar
                    </button>
                </div>

            </div>
        </div>
    </div>

    <!-- Script para manejar el chat -->
    <script>
        document.getElementById("send-message").addEventListener("click", function() {
            const messageInput = document.getElementById("user-message");
            const chatContainer = document.getElementById("messages");

            let userMessage = messageInput.value.trim();
            if (userMessage === "") return;

            // Agregar mensaje del usuario
            let userBubble = `<div class="text-left">
                <div class="inline-block bg-blue-500 text-white p-2 rounded-lg max-w-xs">
                    ${userMessage}
                </div>
            </div>`;
            chatContainer.innerHTML += userBubble;
            messageInput.value = "";

            // Enviar consulta al backend (Laravel)
            fetch("{{ route('chat.ask') }}", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-TOKEN": "{{ csrf_token() }}"
                },
                body: JSON.stringify({ message: userMessage })
            })
            .then(response => response.json())
            .then(data => {
                let botBubble = `<div class="text-right">
                    <div class="inline-block bg-white-300 text-white white:bg-white-600 p-2 rounded-lg max-w-xs">
                        ${data.response}
                    </div>
                </div>`;
                chatContainer.innerHTML += botBubble;
                chatContainer.scrollTop = chatContainer.scrollHeight;
            })
            .catch(error => console.error("Error:", error));
        });
    </script>

</x-app-layout>

