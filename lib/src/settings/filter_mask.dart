class FilterMask {
  FilterMask._();

  static Map<String, RegExp> number = {
    "0": RegExp(r'[0-9]'),
  };
  static Map<String, RegExp> upperCase = {
    "A": RegExp(r'[A-Z]'),
  };
  static Map<String, RegExp> lowerCase = {
    "a": RegExp(r'[a-z]'),
  };
  static Map<String, RegExp> anyCase = {
    "x": RegExp(r'[a-zA-Z]'),
  };
  static Map<String, RegExp> numberAndLetter = {
    "@": RegExp(r'[a-zA-Z0-9]'),
  };
}
