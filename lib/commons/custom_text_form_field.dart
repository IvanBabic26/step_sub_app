import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubStepTextFormField extends StatelessWidget {
  const SubStepTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    required this.onChanged,
    this.controller,
    this.validator,
    required this.onFieldSubmitted,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
  });

  final String? hintText;
  final String? labelText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String) onFieldSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      controller: controller,
      decoration: InputDecoration(hintText: hintText, labelText: labelText),
      onChanged: (e) => onChanged(e),
      validator: validator,
      onFieldSubmitted: (e) => onFieldSubmitted(e),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
    );
  }
}
