import 'package:components_venver/src/settings/filter_mask.dart';

class MaskType {
  static const String cpf = "000.000.000-00";
  static const String cnpj = "00.000.000/0000-00";
  static const String date = "00/00/0000";
  static const String cep = "00000000";
  // static const String phone8 = "0000 0000";
  // static const String phone9 = "00000 0000";
  // static const String phone10 = "(00) 0000 0000";
  // static const String phone11 = "(00) 00000 0000";
  // static const String phone12 = "+00 (00) 0000 0000";
  // static const String phone13 = "+00 (00) 00000 0000";
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
    for(String s in _phones) {
      int numbersQuantityInPhones = s.replaceAll(RegExp(r'[^0-9]'), "").length;
      if(numbersQuantity == numbersQuantityInPhones) {
        return s;
      }
    }
    return "";
  }
}

