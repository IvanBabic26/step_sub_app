import 'package:flutter/cupertino.dart';
import 'package:step_sub/commons/strings.dart';

class TextFieldValidators {
  String? validateName(String value, bool firstName, BuildContext context) {
    final strings = LocalizedStrings(context);
    if (value.isEmpty) {
      return firstName ? strings.pleaseEnterYourFirstName : strings.pleaseEnterYourLastName;
    }
    return null;
  }

  String? validateMobile(String value, BuildContext context) {
    final strings = LocalizedStrings(context);
    if (value.isEmpty) {
      return strings.pleaseEnterAPhoneNumber;
    } else if (value.startsWith('+')) {
      if (value.length != 12) {
        return strings.pleaseEnterA12DigitNumberWithAreaCode;
      }
    } else if (value.length != 10) {
      return strings.pleaseEnterA10DigitNumber;
    }
    return null;
  }

  String? validateEmail(String email, BuildContext context) {
    final strings = LocalizedStrings(context);
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (email.isEmpty) {
      return strings.pleaseEnterAnEmail;
    } else if (!regex.hasMatch(email)) {
      return strings.pleaseEnterAValidEmail;
    }
    return null;
  }
}
