import 'package:flutter/material.dart';
import 'package:suitmedia/utils/app_color.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColor.buttonColor,
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
