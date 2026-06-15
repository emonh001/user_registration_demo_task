import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.trailing,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.tertiary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          textInputAction: textInputAction,
          style: const TextStyle(
            color: AppColors.tertiary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 13,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(color: AppColors.primary, width: 1.4),
            errorBorder: _border(color: Colors.red),
            focusedErrorBorder: _border(color: Colors.red, width: 1.4),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({
    Color color = AppColors.border,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}