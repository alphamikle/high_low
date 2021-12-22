import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.controller,
    this.backgroundColor,
    this.suffixIcon,
    this.hint,
    this.textColor,
    Key? key,
  }) : super(key: key);

  final Color? backgroundColor;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? hint;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.transparent,
        style: BorderStyle.none,
        width: 1,
      ),
    );

    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor ?? AppTheme.of(context).inputColor,
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        isDense: true,
        hintText: hint,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 30,
        ),
      ),
      style: TextStyle(
        color: textColor ?? AppTheme.of(context).titleColor,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
    );
  }
}
