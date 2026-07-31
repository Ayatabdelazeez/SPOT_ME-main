import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class LoadingWidget extends StatelessWidget {
  final String? text;

  const LoadingWidget({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 45,
            height: 45,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.blue,
            ),
          ),

          if (text != null) ...[
            const SizedBox(height: 20),

            Text(
              text!,
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
            ),
          ]
        ],
      ),
    );
  }
}