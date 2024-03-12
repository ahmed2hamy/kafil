import 'package:kafil/constants/constants.dart';

class AppValidators {
  static const bool _disableValidatorsForDebugging = false;

  static String? fieldRequiredValidator(String? input) {
    if (_disableValidatorsForDebugging) return null;

    if (input == null || input.isEmpty) {
      return kFieldRequiredString;
    } else {
      return null;
    }
  }

  static String? loginEmailValidator(String? input) {
    if (_disableValidatorsForDebugging) return null;

    if (input == null || input.isEmpty) {
      return kEnterEmailString;
    } else {
      return null;
    }
  }

  static String? loginPasswordValidator(String? input) {
    if (_disableValidatorsForDebugging) return null;

    if (input == null || input.isEmpty) {
      return kEnterPasswordString;
    } else {
      return null;
    }
  }

  static String? emailValidator(String? input) {
    if (_disableValidatorsForDebugging) return null;

    if (input == null ||
        input.isEmpty ||
        input.contains(kWhitespaceRegex) ||
        !_isValidEmail(input)) {
      return kEnterValidEmailString;
    } else {
      return null;
    }
  }

  static bool _isValidEmail(String email) {
    return kIsEmailRegex.hasMatch(email);
  }

  static String? passwordValidator(String? input) {
    if (_disableValidatorsForDebugging) return null;

    if (input == null || input.isEmpty) {
      return kEnterPasswordString;
    } else if (input.length < 8) {
      return kPasswordMustBe8CharactersString;
    } else {
      return null;
    }
  }

  static String? passwordMatchValidator(String? input, String password) {
    if (_disableValidatorsForDebugging) return null;

    if (input != password) {
      return kPasswordNotMatchedMessageString;
    } else {
      return null;
    }
  }

  static String? aboutMeTextValidator(String? input) {
    if (_disableValidatorsForDebugging) return null;

    if (input == null || input.isEmpty) {
      return kFieldRequiredString;
    } else if (input.length < 10 || input.length > 1000) {
      return kABoutMeTextValidationMessageString;
    }  else {
      return null;
    }
  }
}
