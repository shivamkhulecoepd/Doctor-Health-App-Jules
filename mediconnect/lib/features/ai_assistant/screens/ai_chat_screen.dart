import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hello Sarah! I am your AI Health Assistant. How can I help you today?', isUser: false),
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: _controller.text, isUser: true));
      _controller.clear();
      // Simulate AI response
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add(ChatMessage(text: 'I am analyzing your query. Please give me a moment.', isUser: false));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(radius: 15, backgroundColor: colorScheme.primary, child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18)),
            const SizedBox(width: 10),
            Text('AI Assistant', style: TextStyle(color: colorScheme.onSurface)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 300),
                  child: Align(
                    alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        color: message.isUser ? colorScheme.primary : colorScheme.surface,
                        borderRadius: BorderRadius.circular(20).copyWith(
                          bottomRight: message.isUser ? const Radius.circular(0) : const Radius.circular(20),
                          bottomLeft: message.isUser ? const Radius.circular(20) : const Radius.circular(0),
                        ),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(color: message.isUser ? colorScheme.onPrimary : colorScheme.onSurface),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: colorScheme.surface),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Type your symptoms...',
                hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                filled: true,
                fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(Icons.send, color: colorScheme.primary),
            style: IconButton.styleFrom(backgroundColor: colorScheme.primary.withOpacity(0.1)),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}
