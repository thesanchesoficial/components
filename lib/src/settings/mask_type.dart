class MaskType {
  MaskType._();

  static const String cpf = "000.000.000-00";
  static const String cnpj = "00.000.000/0000-00";
  static const String date = "00/00/0000";
  static const String time = "00:00:00";
  static const String dateTime = "00/00/0000 00:00:00";
  static const String cep = "00000000";
  static const String cardNumber = "0000 0000 0000 0000";
  static const String cardCvv = "0000";
  static const String cardDateYYYY = "00/0000";
  static const String cardDateYY = "00/00";

  static final List<String> _phones = const [
    "0000 0000",
    "00000 0000",
    "(00) 0000 0000",
    "(00) 00000 0000",
    "+00 (00) 0000 0000",
    "+00 (00) 00000 0000",
  ];

  static String phones(int numbersQuantity) {
    assert(_phones.isNotEmpty, "To use this method, the '_phones' list can not be empty");
    for(String phone in _phones) {
      int numbersQuantityInPhones = phone.replaceAll(RegExp(r'[^0-9]'), "").length;
      if(numbersQuantity == numbersQuantityInPhones) {
        return phone;
      }
    }
    return ""; // ! throw exception
  }

  static String integer([int placesQuantity = 9]) {
    assert(placesQuantity != null && placesQuantity > 0);
    return "0" * placesQuantity;
  }
}

