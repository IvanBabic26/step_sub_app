class TextFieldValidators {
  String? validateName(String value, bool firstName) {
    if (value.isEmpty) {
      return 'Please enter your ${firstName ? 'first name' : 'last name'}.';
    }
    return null;
  }

  String? validateMobile(String value) {
    if (value.isEmpty) {
      return 'Please enter a phone number';
    } else if (value.startsWith('+')) {
      if (value.length != 12) {
        return 'Please enter a 12 digit number with area code';
      }
    } else if (value.length != 10) {
      return 'Please enter a 10 digit number';
    }
    return null;
  }

  String? validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (email.isEmpty) {
      return 'Please enter an email.';
    } else if (!regex.hasMatch(email)) {
      return 'Please enter a valid email.';
    }
    return null;
  }
}
