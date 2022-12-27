import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPassword;
  final void Function(String value) onFieldSubmitted;
  final void Function() onTap;
  final void Function()? suffixTap;

  final void Function(String value) onChanged;
  final String? Function(String? value) onValidate;
  final IconData prefixIcon;
  final Text label;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  DefaultFormField({
    this.suffixTap,
    this.suffixIcon,
    this.focusNode,
    required this.controller,
    required this.textInputType,
    required this.isPassword,
    required this.onFieldSubmitted,
    required this.onTap,
    required this.onChanged,
    required this.onValidate,
    required this.prefixIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      validator: onValidate,
      decoration: InputDecoration(
        label: label,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: GestureDetector(
          onTap: suffixTap,
          child: Icon(
            suffixIcon,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
