import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';

class SubStepTextFormField extends StatelessWidget {
  const SubStepTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    required this.onChanged,
    this.focusNode,
    this.controller,
    this.validator,
    required this.onFieldSubmitted,
    this.keyboardType,
    this.inputFormatters,
  });

  final String? hintText;
  final String? labelText;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String) onFieldSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: StepSubTextStyles.titleTextStyle,
        labelText: labelText,
        labelStyle: StepSubTextStyles.titleTextStyle,
        filled: true,
        fillColor: StepSubColors.grey.withOpacity(0.2),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: (e) => onChanged(e),
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: (e) => onFieldSubmitted(e),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
