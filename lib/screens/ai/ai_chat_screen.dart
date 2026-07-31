import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_colors.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  static const String _apiUrl =
      "https://chat-bot-spot-me-drab.vercel.app/api/chat";

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _history = [];

  final List<_ChatMessage> _uiMessages = [
    _ChatMessage(
      text: "Hello! I'm your AI Coach. Ask me about any player or stat.",
      isAi: true,
    ),
  ];

  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _uiMessages.add(_ChatMessage(text: text, isAi: false));
      _history.add({"role": "user", "content": text});
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"messages": _history}),
          )
          .timeout(const Duration(seconds: 45));
      // Longer timeout since the free-tier model can be slow under load

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final aiReply =
            (data["response"] as String?) ??
            "Sorry, I couldn't read that response.";

        setState(() {
          _uiMessages.add(_ChatMessage(text: aiReply, isAi: true));
          _history.add({"role": "assistant", "content": aiReply});
        });
      } else if (response.statusCode == 429) {
        setState(() {
          _uiMessages.add(
            _ChatMessage(
              text:
                  "The AI request limit was reached. Please try again in a bit.",
              isAi: true,
            ),
          );
        });
      } else {
        setState(() {
          _uiMessages.add(
            _ChatMessage(
              text: "Server error (${response.statusCode}). Please try again.",
              isAi: true,
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _uiMessages.add(
          _ChatMessage(
            text:
                "Can't reach the server right now. Check your connection and try again.",
            isAi: true,
          ),
        );
      });
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
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
        title: const Text("AI Coach"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: _uiMessages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _uiMessages.length) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }
                final msg = _uiMessages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Align(
                    alignment: msg.isAi
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: _Message(text: msg.text, isAi: msg.isAi),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Ask AI Coach...",
                      filled: true,
                      fillColor: AppColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: AppColors.blue,
                  child: IconButton(
                    onPressed: _isLoading ? null : _sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isAi;
  _ChatMessage({required this.text, required this.isAi});
}

class _Message extends StatelessWidget {
  final String text;
  final bool isAi;
  const _Message({required this.text, required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: const BoxConstraints(maxWidth: 270),
      decoration: BoxDecoration(
        color: isAi ? AppColors.card : AppColors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
