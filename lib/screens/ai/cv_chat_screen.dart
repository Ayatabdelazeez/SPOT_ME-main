import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'cv_api_service.dart'; 

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class CVChatScreen extends StatefulWidget {
  const CVChatScreen({super.key});

  @override
  State<CVChatScreen> createState() => _CVChatScreenState();
}

class _CVChatScreenState extends State<CVChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  
  String? _sessionId;
  bool _isLoading = true;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _startInterviewSession(); // The session begins as soon as the screen opens 
  }

  // 1.Starting session from the API
  void _startInterviewSession() async {
    
      final data = await CvApiService.startInterview();
      setState(() {
        _sessionId = data['session_id'];
        _messages.add(ChatMessage(text: data['message'], isUser: false));
        _isLoading = false;
      });
    
  }

  // 2. send the answer and receive the next question 
  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _sessionId == null || _isLoading) return;

    _messageController.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    try {
      final data = await CvApiService.sendAnswer(
        sessionId: _sessionId!,
        message: text,
      );

      setState(() {
        _messages.add(ChatMessage(text: data['message'], isUser: false));
        _isDone = data['is_done'] ?? false;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("An error occurred while sending the answer ");
    }
  }

  // 3. CV Generator 
  void _generateCv() async {
    if (_sessionId == null) return;

    setState(() => _isLoading = true);

    try {
      final data = await CvApiService.generateCv(_sessionId!);
      setState(() => _isLoading = false);

      final pdfUrl = "${CvApiService.baseUrl}${data['pdf_url']}";

      // open a dialog to alert the user with the PDF link or display it 
      _showCvReadyDialog(pdfUrl, data['summary']);
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar("An error occurred while generating the cv");
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: AppColors.red),
    );
  }

  void _showCvReadyDialog(String pdfUrl, String? summary) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text("The CV has been successfully created", style: TextStyle(color: Colors.white)),
        content: Text(
          summary ?? "Your CV is ready for download now",
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
            onPressed: () {
              // Open the pdf link in the browser
              Navigator.pop(context);
            },
            child: const Text("Download PDF"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AI CV Generator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        actions: [
          // button appeare when isDone will be true 
          TextButton.icon(
            onPressed: _isDone ? _generateCv : null,
            icon: Icon(Icons.auto_awesome, color: _isDone ? AppColors.blue : Colors.white24, size: 18),
            label: Text(
              "Generate CV",
              style: TextStyle(
                color: _isDone ? AppColors.blue : Colors.white24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.blue)),
                  SizedBox(width: 8),
                  Text("AI write now.", style: TextStyle(color: Colors.white54, fontSize: 13)),
                ],
              ),
            ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? AppColors.blue : AppColors.card,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Text(message.text, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4)),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppColors.card,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: !_isDone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: _isDone ? "The question have ended; click Generate CV" : "write your answer here ...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                  fillColor: AppColors.background,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: _isDone ? Colors.grey : AppColors.blue,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: _isDone ? null : _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}