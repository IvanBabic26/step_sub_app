import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:step_sub/commons/custom_text_form_field.dart';
import 'package:step_sub/utilities/validators.dart';

class FormStepOne extends StatefulWidget {
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
  State<FormStepOne> createState() => _FormStepOneState();
}

class _FormStepOneState extends State<FormStepOne> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  @override
  void initState() {
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.emailAddress);
    _phoneController = TextEditingController(text: widget.phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 8),
            child: Column(
              children: [
                SubStepTextFormField(
                  controller: _firstNameController,
                  labelText: 'First name',
                  hintText: 'First name',
                  onChanged: (e) => widget.onFirstNameChanged(e),
                  focusNode: _firstNameFocusNode,
                  validator: (e) => TextFieldValidators().validateName(e ?? '', true),
                  onFieldSubmitted: (e) => widget.onFieldSubmitted(e),
                ),
                const SizedBox(height: 8),
                SubStepTextFormField(
                  controller: _lastNameController,
                  labelText: 'Last name',
                  hintText: 'Last name',
                  onChanged: (e) => widget.onLastNameChanged(e),
                  focusNode: _lastNameFocusNode,
                  validator: (e) => TextFieldValidators().validateName(e ?? '', false),
                  onFieldSubmitted: (e) => widget.onFieldSubmitted(e),
                ),
                const SizedBox(height: 8),
                SubStepTextFormField(
                  controller: _emailController,
                  labelText: 'Email address',
                  hintText: 'Email address',
                  onChanged: (e) => widget.onEmailChanged(e),
                  focusNode: _emailFocusNode,
                  validator: (e) => TextFieldValidators().validateEmail(e ?? ''),
                  onFieldSubmitted: (e) => widget.onFieldSubmitted(e),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                SubStepTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone number',
                  hintText: 'Phone number',
                  onChanged: (e) => widget.onPhoneChanged(e),
                  focusNode: _phoneFocusNode,
                  validator: (e) => TextFieldValidators().validateMobile(e ?? ''),
                  onFieldSubmitted: (e) => widget.onFieldSubmitted(e),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,+]')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
