import 'package:dash_cup/core/resources/constatnt_manager.dart';

class Validator {
  static String? name(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return "This field is required";
    }

    return null;
  }

  static String? email(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "This field is required";
    } else if (!RegexConstants.email.hasMatch(email)) {
      return "Please,enter valid email";
    }
    return null;
  }

  static String? password(String? password) {
    if (password == null || password.trim().isEmpty) {
      return "This field is required";
    } else if (!RegexConstants.password.hasMatch(password)) {
      return "Password is weak";
    }
    return null;
  }

  static String? phone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return "This field is required";
    } else if (!RegexConstants.phone.hasMatch(phone)) {
      return "Please,enter valid phone";
    }

    return null;
  }
}
