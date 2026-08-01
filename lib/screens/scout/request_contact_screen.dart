import 'package:flutter/material.dart';
import '../../models/player_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

class RequestContactScreen extends StatefulWidget {
  final PlayerModel player;

  const RequestContactScreen({super.key, required this.player});

  @override
  State<RequestContactScreen> createState() => _RequestContactScreenState();
}

class _RequestContactScreenState extends State<RequestContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clubController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String _requestType = 'Trial / Trialist';

  final List<String> _requestTypes = [
    'Trial / Trialist',
    'Official Transfer',
    'General Inquiry',
  ];

  @override
  void dispose() {
    _clubController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Connect with Player", style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.blue.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.blue,
                      child: Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.player.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${widget.player.sport} • ${widget.player.position} (${widget.player.club})",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text("Contact Request Details", style: AppTextStyles.sectionTitle),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _clubController,
                label: "Club / Scouting Agency Name",
                hint: "e.g., Ahly FC Youth / Talent Agency",
                icon: Icons.shield_outlined,
                validator: (val) =>
                    val == null || val.isEmpty ? "Please enter your club name" : null,
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: _phoneController,
                label: "Scout Phone Number",
                hint: "010xxxxxxxx",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.isEmpty ? "Please enter contact number" : null,
              ),

              const SizedBox(height: 16),

              const Text(
                "Request Purpose",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _requestType,
                    isExpanded: true,
                    dropdownColor: AppColors.card,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    items: _requestTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _requestType = val);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _buildTextField(
                controller: _messageController,
                label: "Offer / Trial Details",
                hint: "Mention trial dates, location, or official offer details...",
                icon: Icons.message_outlined,
                maxLines: 4,
              ),

              const SizedBox(height: 28),

              CustomButton(
                text: "Submit Connection Request",
                icon: Icons.send_rounded,
                onPressed: _submitRequest,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
            prefixIcon: Icon(icon, color: Colors.white60, size: 20),
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Request sent to SpotMe team for ${widget.player.name}! We will contact you shortly.",
          ),
          backgroundColor: AppColors.blue,
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.pop(context); 
    }
  }
}
