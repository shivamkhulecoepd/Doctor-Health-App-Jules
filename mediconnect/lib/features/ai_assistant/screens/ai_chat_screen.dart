import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.auto_awesome_rounded, color: colorScheme.primary, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Text('AI Health Assistant', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(24.w),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(context, message);
              },
            ),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage message) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: GlassCard(
            padding: EdgeInsets.all(16.r),
            opacity: message.isUser ? 0.9 : 0.72,
            color: message.isUser ? colorScheme.primary : null,
            borderRadius: BorderRadius.circular(20.r).copyWith(
              bottomRight: message.isUser ? Radius.circular(4.r) : Radius.circular(20.r),
              bottomLeft: message.isUser ? Radius.circular(20.r) : Radius.circular(4.r),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? colorScheme.onPrimary : colorScheme.onSurface,
                fontSize: 15.sp,
                height: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 40.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: TextField(
                controller: _controller,
                style: TextStyle(color: colorScheme.onSurface, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Describe your symptoms...',
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle, boxShadow: DesignSystem.softShadow),
              child: Icon(Icons.send_rounded, color: colorScheme.onPrimary, size: 20.sp),
            ),
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
