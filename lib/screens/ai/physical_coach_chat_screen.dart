import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/app_colors.dart';

/// شاشة شات مع الكوتش الفيزيكال - UI فقط حاليًا.
/// المستخدم يقدر يرفع فيديو من الجهاز أو يكتب رسالة عادية.
/// نداء الـ AI هيتحط بعدين مكان الـ TODO في دالة _send() من غير ما تغيّر الديزاين.
class PhysicalCoachChatScreen extends StatefulWidget {
  const PhysicalCoachChatScreen({super.key});

  @override
  State<PhysicalCoachChatScreen> createState() =>
      _PhysicalCoachChatScreenState();
}

class _ChatMessage {
  final String? text;
  final File? videoFile;
  final bool isUser;

  _ChatMessage({this.text, this.videoFile, required this.isUser});
}

class _PhysicalCoachChatScreenState extends State<PhysicalCoachChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'Hi! Send me a video of your exercise or ask me anything.',
      isUser: false,
    ),
  ];

  File? _pendingVideo;
  bool _isPickingVideo = false;

  Future<void> _pickVideo() async {
    setState(() => _isPickingVideo = true);
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
      );
      if (video != null) {
        setState(() => _pendingVideo = File(video.path));
      }
    } finally {
      setState(() => _isPickingVideo = false);
    }
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty && _pendingVideo == null) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          text: text.isEmpty ? null : text,
          videoFile: _pendingVideo,
          isUser: true,
        ),
      );
      _controller.clear();
      _pendingVideo = null;

      // TODO: هنا هيتحط نداء الـ AI/Backend اللي بياخد النص و/أو الفيديو
      // ويرجع رد الكوتش، وترجعي تضيفيه هنا كـ _ChatMessage(isUser: false)
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chat With Your Coach',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _MessageBubble(message: _messages[index]);
                },
              ),
            ),
            if (_pendingVideo != null)
              _VideoPreviewChip(
                fileName: _pendingVideo!.path.split('/').last,
                onRemove: () => setState(() => _pendingVideo = null),
              ),
            _InputBar(
              controller: _controller,
              onPickVideo: _pickVideo,
              onSend: _send,
              isPickingVideo: _isPickingVideo,
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== Widgets =====================

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: isUser ? AppColors.primaryGradient : null,
          color: isUser ? null : AppColors.card,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.videoFile != null)
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_circle_fill_rounded,
                        color: AppColors.white, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        message.videoFile!.path.split('/').last,
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            if (message.text != null)
              Text(
                message.text!,
                style: const TextStyle(color: AppColors.white, fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoPreviewChip extends StatelessWidget {
  final String fileName;
  final VoidCallback onRemove;

  const _VideoPreviewChip({
    required this.fileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          const Icon(Icons.videocam_rounded, color: AppColors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(color: AppColors.white, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded,
                color: AppColors.grey, size: 18),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPickVideo;
  final VoidCallback onSend;
  final bool isPickingVideo;

  const _InputBar({
    required this.controller,
    required this.onPickVideo,
    required this.onSend,
    required this.isPickingVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: isPickingVideo
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.blue,
                    ),
                  )
                : const Icon(Icons.videocam_rounded, color: AppColors.blue),
            onPressed: isPickingVideo ? null : onPickVideo,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: AppColors.white),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: AppColors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onSend,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded,
                  color: AppColors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
