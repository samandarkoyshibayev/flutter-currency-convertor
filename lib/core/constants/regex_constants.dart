abstract class RegexConstants {
  static final RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp password = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );
  static final RegExp phone = RegExp(r'^\+?[1-9]\d{7,14}$');
  static final RegExp uzbekPhone = RegExp(r'^\+998[0-9]{9}$');
  static final RegExp otp = RegExp(r'^\d{6}$');
  static final RegExp url = RegExp(
    r'https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&/=]*)',
  );

  static final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp onlyNumbers = RegExp(r'^\d+$');
  static final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

  static final RegExp noWhitespace = RegExp(r'^\S+$');
  static final RegExp hasUppercase = RegExp(r'[A-Z]');
  static final RegExp hasLowercase = RegExp(r'[a-z]');
  static final RegExp hasDigit = RegExp(r'\d');
  static final RegExp hasSpecial = RegExp(r'[@$!%*?&]');
}
