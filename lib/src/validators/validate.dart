import 'package:cpfcnpj/cpfcnpj.dart';
import '../functions/format.dart';
// pubspec.yaml
// dependencies:
//   cpfcnpj: ^1.0.3

class OwValidate {
  const OwValidate._();

  // ! Separete to an initializer
  static const int MAX_CHARACTERS = 255;

  static const int minLengthName = 5;

  /// Returns [false] if the [value] <= [minLength]; or > [maxLength]
  ///
  /// If [valor] is "null" (*String*), it returns [false]
  static bool text(dynamic value, {int minLength = 0, int maxLength}) {
    if (value.toString() == "null" || 
        value.length <= minLength ||
        (maxLength != null && value.length > maxLength)
    ) return false;
    return true;
  }

  /// Returns [false] if the [value] <= [minLength]; or > [maxLength]
  static bool list(List value, {int minLength = 0, int maxLength}) {
    if (value.toString() == "null" || value.length <= minLength) return false;
    if (maxLength != null && value.length > maxLength)
      return false;
    else
      return true;
  }

  /// Validate the name
  static bool nome(String value) {
    bool valid = text(value, minLength: minLengthName, maxLength: MAX_CHARACTERS);
    if (!valid) return false;

    if (value.contains("\n") || value.contains("  ")) return false;
    final regex = RegExp(
      r"^([a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{2,}\s[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{1,}'?-?[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{1,}\s?([a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{1,})?)$",
    );
    return regex.hasMatch(value);
  }

  /// Validate the email
  static bool email(String value) {
    if (value == null) return false;
    final Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  /// Validate CPF and CNPJ (both)
  static bool cpfCnpj(String value) {
    if (value == null) return false;
    return (CPF.isValid(value) || CNPJ.isValid(value));
  }

  /// Validate only the CPF
  static bool cpf(String value) {
    if (value == null) return false;
    return CPF.isValid(value);
  }

  /// Validate only the CNPJ
  static bool cnpj(String value) {
    if (value == null) return false;
    return CNPJ.isValid(value);
  }

  /// Validate the password (length > 5)
  static bool password(String valor) {
    if (valor == null || valor.length > MAX_CHARACTERS) return false;
    return text(valor, minLength: 5);
  }

  /// Validate the phone number
  ///
  /// Remove the characters ["+() -"] and verify if the rest is only numbers
  ///
  /// [value] needs to have between 8 and 13 numbers
  static bool phone(String value) {
    if (value == null) return false;
    if (value.length < 8 || value.length > 19) return false;
    String valueWithoutCharacters = OwFormat.removerCharacters(value, "+() -");
    RegExp regex = RegExp(r'[^0-9]{1}');
    if (valueWithoutCharacters.length < 8 || valueWithoutCharacters.length > 13)
      return false;
    for (int i = 0; i < valueWithoutCharacters.length; i++) {
      if (regex.hasMatch(valueWithoutCharacters[i])) return false;
    }
    return true;
  }




  // ! Revisr
  /// [value] needs to be: dd/MM/yyyy
  static bool date(String value) {
    if (value == null) return false;
    String temp = stringToDateTime(value);
    final date = DateTime.parse(temp);
    final originalFormatString = toOriginalFormatString(date);
    return temp == originalFormatString;
  }

  static String stringToDateTime(String input) {
    input = input.replaceAll("-", "");
    String dia = input.substring(0, 2);
    String mes = input.substring(2, 4);
    String ano = input.substring(4);
    return "$ano$mes$dia";
  }

  static bool validAge(String input) {
    String temp = stringToDateTime(input);
    final date = DateTime.parse(temp);
    if(date.isAfter(DateTime.now().subtract(Duration(days: 4380)))) {
      return false;
    }
    return true;
  }

  static String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }
}
