import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:step_sub/commons/custom_text_form_field.dart';
import 'package:step_sub/commons/strings.dart';
import 'package:step_sub/utilities/validators.dart';

class FormStepOne extends StatelessWidget {
  const FormStepOne({
    super.key,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onFieldSubmitted,
    required this.formKey,
    required this.scrollController,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
  });

  final Function(String) onFirstNameChanged;
  final Function(String) onLastNameChanged;
  final Function(String) onEmailChanged;
  final Function(String) onPhoneChanged;
  final Function(String) onFieldSubmitted;
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final String? firstName;
  final String? lastName;
  final String? emailAddress;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final strings = LocalizedStrings(context);
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 8),
            child: Column(
              children: [
                SubStepTextFormField(
                  labelText: strings.firstName,
                  hintText: strings.firstName,
                  onChanged: (e) => onFirstNameChanged(e),
                  validator: (e) => TextFieldValidators().validateName(e ?? '', true,context),
                  onFieldSubmitted: (e) => onFieldSubmitted(e),
                  initialValue: firstName,
                ),
                const SizedBox(height: 16),
                SubStepTextFormField(
                  labelText: strings.lastName,
                  hintText: strings.lastName,
                  onChanged: (e) => onLastNameChanged(e),
                  validator: (e) => TextFieldValidators().validateName(e ?? '', false,context),
                  onFieldSubmitted: (e) => onFieldSubmitted(e),
                  initialValue: lastName,
                ),
                const SizedBox(height: 8),
                SubStepTextFormField(
                  labelText: strings.emailAddress,
                  hintText: strings.emailAddress,
                  onChanged: (e) => onEmailChanged(e),
                  validator: (e) => TextFieldValidators().validateEmail(e ?? '',context),
                  onFieldSubmitted: (e) => onFieldSubmitted(e),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: emailAddress,
                ),
                const SizedBox(height: 8),
                SubStepTextFormField(
                  labelText: strings.phoneNumber,
                  hintText: strings.phoneNumber,
                  onChanged: (e) => onPhoneChanged(e),
                  validator: (e) => TextFieldValidators().validateMobile(e ?? '',context),
                  onFieldSubmitted: (e) => onFieldSubmitted(e),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,+]')),
                  ],
                  initialValue: phoneNumber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
