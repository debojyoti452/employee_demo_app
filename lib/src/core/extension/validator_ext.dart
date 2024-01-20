extension ValidatorExt on String {
  // isEmail validator
  bool get isEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(this);
  }

  // full name validator
  bool get isFullName {
    final fullNameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$');
    return fullNameRegex.hasMatch(this);
  }

  // alphanumeric validator
  bool get isAlphanumeric {
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumericRegex.hasMatch(this);
  }

  // Check if the string is alphanumeric with space, but no special characters
  bool get isAlphanumericWithSpace {
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumericRegex.hasMatch(this);
  }

  // password validator for 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
  bool get isPasswordCompliant {
    String password = this;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > 8;

    return hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters &&
        hasMinLength;
  }

  // Phone number validator
  bool get isPhoneNumber {
    final phoneNumberRegex = RegExp(r'^\+?[0-9]{8,15}$');
    return phoneNumberRegex.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPhoneNumber {
    // Define a regular expression for the desired format
    RegExp regex = RegExp(r'^\+(\d{1,3})(\d{10})$');

    // Use the RegExp's `firstMatch` method to check if the string matches the pattern
    Match? match = regex.firstMatch(this);

    return match != null && match.groupCount == 2;
  }
}


