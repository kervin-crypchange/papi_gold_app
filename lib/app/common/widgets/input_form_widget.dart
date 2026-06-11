import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/extensions/text_theme.dart';
import 'package:papi_gold/app/core/theme/index.dart';

class InputFormWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final bool obscureText;
  final int? maxLength;
  final String? Function(String?) validator;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final Color? color;
  final TextCapitalization textCapitalization;

  const InputFormWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    required this.validator,
    required this.onSaved,
    this.controller,
    this.suffix,
    this.readOnly = false,
    this.enabled = true,
    this.minLines = 1,
    this.maxLines,
    this.initialValue,
    this.color,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: color ?? AppColors.grey),
      initialValue: initialValue,
      minLines: minLines,
      maxLines: obscureText ? 1 : maxLines,
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      autofocus: false,
      keyboardType: keyboardType,
      maxLength: maxLength,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: color ?? AppColors.grey,
          ), 
        ),
        hintText: hintText,
        labelStyle: context.bodySmall.copyWith(
          color: color ?? AppColors.white,
        ),
        labelText: labelText,
        helperText: helperText,
        helperStyle: TextStyle(color: color ?? AppColors.grey),
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
      ),
    );
  }
}