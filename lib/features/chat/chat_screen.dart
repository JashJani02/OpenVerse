import 'package:flutter/material.dart';

import '../../models/message.dart';
import 'chat_controller.dart';

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
          appBar: AppBar(title: const Text("OpenVerse")),
          body: Column(
            children: [
              Expanded(
                child: controller.messages.isEmpty
                    ? const Center(child: Text("Start a conversation"))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final ChatMessage message =
                              controller.messages[index];

                          final isUser = message.isUser;

                          return Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              constraints: const BoxConstraints(maxWidth: 600),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                message.content,
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
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
