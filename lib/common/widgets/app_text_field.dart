import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final Widget? prefixIcon;
  final int maxLines;
  final bool isLabelBold;
  final bool isObcureText;
  final void Function(String) onChanged;
  final TextInputType keyboardType;
  //String? Function(String) validator;

  const AppTextField({
    this.controller,
    required this.hintText,
    required this.labelText,
    this.maxLines = 1,
    this.prefixIcon,
    required this.isLabelBold,
    required this.isObcureText,
    this.keyboardType = TextInputType.text,
    required this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      onChanged: onChanged,
      maxLines: isObcureText ? 1 : maxLines,
      obscureText:  isObcureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        
        labelStyle: TextStyle(
          color: Colors.black,  // Color of the label
          fontSize: 18,         // Font size of the label
          fontWeight: isLabelBold? FontWeight.bold : FontWeight.normal,  // Font weight (make it bold)
          fontStyle: FontStyle.italic, // Optional: italic style for the label
        ),
        prefixIcon: prefixIcon,
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.appColorGray, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.appColorGray, width: 2),
        ),
      ),
    );
  }
}
