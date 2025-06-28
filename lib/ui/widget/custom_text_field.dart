import 'package:contact_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textHint;
  final TextEditingController inputText;
  final void Function(String) text;
  const CustomTextField({
    super.key,
    required this.textHint,
    required this.inputText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: text,
      controller: inputText,
      style: TextStyle(color: AppColors.primaryColor),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hint: Text(textHint, style: TextStyle(color: AppColors.primaryColor)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
