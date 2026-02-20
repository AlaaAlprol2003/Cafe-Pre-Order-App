abstract class RegexConstants {
  static RegExp email = RegExp(
   r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static RegExp phone = RegExp(r'^01[015][0-9]{8}$');
  static RegExp password = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=(?:.*[0-9]){5,})(?=.*[!@#$%^&*(),.?":{}|<>])',
  );
}