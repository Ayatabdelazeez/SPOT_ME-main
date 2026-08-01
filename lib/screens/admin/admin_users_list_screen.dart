import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class AdminUsersListScreen extends StatefulWidget {
  final String roleTitle;

  const AdminUsersListScreen({super.key, required this.roleTitle});

  @override
  State<AdminUsersListScreen> createState() => _AdminUsersListScreenState();
}

class _AdminUsersListScreenState extends State<AdminUsersListScreen> {
  // Mock List
  late List<Map<String, String>> users;

  @override
  void initState() {
    super.initState();
    if (widget.roleTitle.contains("Players")) {
      users = [
        {"name": "Ahmed Mohamed", "detail": "Forward • 20 Yrs", "status": "Active"},
        {"name": "Omar Hassan", "detail": "Midfielder • 19 Yrs", "status": "Active"},
        {"name": "Khaled Ali", "detail": "Defender • 22 Yrs", "status": "Flagged"},
        {"name": "Youssef Ibrahim", "detail": "Goalkeeper • 18 Yrs", "status": "Active"},
      ];
    } else {
      users = [
        {"name": "Captain Mahmoud", "detail": "Ahly FC Scout", "status": "Active"},
        {"name": "Coach Hazem", "detail": "Zamalek Youth Scout", "status": "Active"},
        {"name": "Scout Reda", "detail": "Pyramids FC", "status": "Active"},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.roleTitle, style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final isFlagged = user["status"] == "Flagged";

          return Card(
            color: AppColors.card,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isFlagged ? Colors.orange : AppColors.blue,
                child: Icon(
                  isFlagged ? Icons.warning : Icons.person,
                  color: Colors.white,
                ),
              ),
              title: Text(
                user["name"]!,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${user["detail"]} • Status: ${user["status"]}",
                style: TextStyle(color: isFlagged ? Colors.orange : Colors.white70, fontSize: 12),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.red),
                onPressed: () {
                  setState(() {
                    users.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${user["name"]} deleted from system")),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
