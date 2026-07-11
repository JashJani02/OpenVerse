import 'package:flutter/material.dart';

import '../../models/message.dart';
import 'chat_controller.dart';
import 'widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = ChatController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFF121212),
                  child: controller.messages.isEmpty
                      ? const Center(
                          child: Text(
                            "Start a conversation",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 20,
                          ),
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            final ChatMessage message =
                                controller.messages[index];

                            return MessageBubble(message: message);
                          },
                        ),
                ),
              ),

              if (controller.isSending)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: CircularProgressIndicator(),
                ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          minLines: 1,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            hintText: "Message...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton.filled(
                        onPressed: controller.isSending
                            ? null
                            : controller.sendMessage,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
