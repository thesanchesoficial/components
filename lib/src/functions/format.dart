import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../validators/validate.dart';
import 'package:intl/intl.dart';
// pubspec.yaml
// dependencies:
//   flutter_masked_text: ^0.8.0

class OwFormat {
  const OwFormat._();

  // ! Separete to a initializer
  static const int MAX_CHARACTERS = 255;

  static const String invalidReturnName = "Sem nome";
  static const String invalidReturnUrl = "Sem url";
  static const String invalidReturnDescription = "Sem descrição";
  static const String invalidReturnEmail = "Sem email";
  static const String invalidReturnPhoneNumber = "Sem número de telefone";
  static const String invalidReturnCpfCnpj = "Sem CPF / CNPJ";
  static const String invalidReturnCpf = "Sem CPF";
  static const String invalidReturnCnpj = "Sem CNPJ";

  static const String standardReturnOfNullValue = "null";

  static const String freePriceWord = "Grátis";
  
  static const List<String> phoneNumberMasks = [
    "0000 0000",
    "00000 0000", 
    "(00) 0000 0000",
    "(00) 00000 0000",
    "+00 (00) 0000 0000",
    "+00 (00) 00000 0000",
  ];

  static const String cpfMask = "000.000.000-00";
  static const String cnpjMask = "00.000.000/0000-00";
  
  static const List<String> weekDaysStartSunday = [
    "Domingo", 
    "Segunda", 
    "Terça", 
    "Quarta", 
    "Quinta", 
    "Sexta", 
    "Sábado",
  ];

  static const String yesterdayWord = "Ontem";
  static const String todayWord = "Hoje";
  static const String tomorrowWord = "Amanhã";
  
  static const String dayWord = "dia";
  static const String hourWord = "hora";
  static const String minuteWord = "minuto";
  static const String andWord = "e";

  static const int bottomLimitInMinutes = 5;
  static const int topLimitInMinutes = 5;
  static const String fromWord = "de";
  static const String untilWord = "até";

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturn] if [returnValue] is false
  static String trim(
    String value, 
    String invalidReturn,
    {bool returnValueAsInvalid = false,
  }) {
    if(OwValidate.text(value)) {
      return value.toString().trim();
    } else {
      if(returnValueAsInvalid) {
        return value.toString();
      } else {
        return invalidReturn ?? standardReturnOfNullValue;
      }
    }
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnName] if [returnValue] is false
  static String name(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    return trim(
      value, 
      invalidReturnName, 
      returnValueAsInvalid: returnValueAsInvalid,
    );
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnUrl] if [returnValue] is false
  static String url(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    return trim(
      value, 
      invalidReturnUrl, 
      returnValueAsInvalid: returnValueAsInvalid,
    );
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnDescription] if [returnValue] is false
  static String description(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    return trim(
      value, 
      invalidReturnDescription, 
      returnValueAsInvalid: returnValueAsInvalid,
    );
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnEmail] if [returnValue] is false
  static String email(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    return trim(
      value, 
      invalidReturnEmail, 
      returnValueAsInvalid: returnValueAsInvalid,
    );
  }

  /// Verify the quantity of numbers (ignoring others characters) and insert into the mask according to [phoneNumberMasks]
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnPhoneNumber] if [returnValueAsInvalid] is false
  static String phoneNumber(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    if(valueNumbers.length != 0) {
      phoneNumberMasks?.forEach((element) {
        String elementNumbers = element.toString().replaceAll(
          RegExp(r'[^0-9]'), 
          '',
        );
        if(elementNumbers.length == valueNumbers.length) {
          final result = MaskedTextController(
            mask: element, 
            text: valueNumbers,
          );
          return result.text;
        }
      });
    }
    if(returnValueAsInvalid) {
      return value.toString();
    } else {
      return invalidReturnPhoneNumber ?? standardReturnOfNullValue;
    }
  }

  /// Use the mask "000.000.000-00" (cpf) or "00.000.000/0000-00" (cnpj)
  /// 
  /// Verify the quantity of numbers (ignoring others characters) and insert into according to the mask
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnCpfCnpj] if [returnValueAsInvalid] is false
  static String cpfCnpj(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    String mask;
    if(valueNumbers.length == 11) {
      mask = cpfMask;
    } else if(valueNumbers.length == 14) {
      mask = cnpjMask;
    } else {
      if(returnValueAsInvalid) {
        return value.toString();
      } else {
        return invalidReturnCpfCnpj ?? standardReturnOfNullValue;
      }
    }
    final result = MaskedTextController(
      mask: mask, 
      text: valueNumbers,
    );
    return result.text;
  }

  /// Use the mask "000.000.000-00"
  ///
  /// Verify the quantity of numbers (ignoring others characters) and insert into according to the mask
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnCpf] if [returnValueAsInvalid] is false
  static String cpf(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    if(valueNumbers.length == 11) {
      final result = MaskedTextController(
        mask: cpfMask, 
        text: valueNumbers,
      );
      return result.text;
    } else {
      if(returnValueAsInvalid) {
        return value.toString();
      } else {
        return invalidReturnCpf ?? standardReturnOfNullValue;
      }
    }
  }

  /// Use the mask "00.000.000/0000-00"
  ///
  /// Verify the quantity of numbers (ignoring others characters) and insert into according to the mask
  ///
  /// If it's not valid, the return can be the same [value] if [returnValueAsInvalid] is true, or [invalidReturnCnpj] if [returnValueAsInvalid] is false
  static String cnpj(
    String value, 
    {bool returnValueAsInvalid = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    if(valueNumbers.length == 11) {
      final result = MaskedTextController(
        mask: cnpjMask, 
        text: valueNumbers,
      );
      return result.text;
    } else {
      if(returnValueAsInvalid) {
        return value.toString();
      } else {
        return invalidReturnCnpj ?? standardReturnOfNullValue;
      }
    }
  }

  /// Upper case on the first letter, and the rest on lower case
  static String upperFirstLowerRest(String value) {
    if(value != null) {
      if(value.length > 1) {
        return "${value.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
      } else {
        return "${value.toUpperCase()}";
      }
    } else {
      return standardReturnOfNullValue;
    }
  }

  /// Upper case on the first letter, and the rest keeps the same
  static String upperFirstKeepRest(String value) {
    if(value != null) {
      if(value.length > 1) {
        return "${value.substring(0, 1).toUpperCase()}${value.substring(1)}";
      } else {
        return "${value.toUpperCase()}";
      }
    } else {
      return standardReturnOfNullValue;
    }
  }

  /// Upper case on the first letter of each word
  static String upperFirstEachWord(String value) {
    if(value != null) {
      List<String> words = value?.split(" ");
      String result = "";
      words?.forEach((element) {
        result += "${upperFirstLowerRest(value)}";
        if(element != words[words.length - 1])
          result += " ";
      });
      return result;
    } else {
      return standardReturnOfNullValue;
    }
  }

  /// Only upper case
  static String upperCase(String value) {
    return value?.toUpperCase() ?? standardReturnOfNullValue;
  }

  /// Only lower case
  static String lowerCase(String value) {
    return value?.toLowerCase() ?? standardReturnOfNullValue;
  }



  /// ! Old fromCurrencyToDouble method (delete)
  static double oldFromCurrencyToDouble(String value) { // TODO: Deletar função (fromCurrencyToDouble() subistituiu)
    String decimalSeparator = "";
    RegExp regex;
    String numbers;

    if(value.length > 2) {
      decimalSeparator = value.substring(
        value.length - 3,
      ).replaceAll(
        RegExp(r'[^,.]'), 
        '',
      );
    }
    regex = RegExp(r'[^0-9.,]');
    numbers = value.replaceAll(regex, '');

    if(decimalSeparator == ".") {
      numbers = numbers.replaceAll(",", "");
    } else if(decimalSeparator == ",") {
      numbers = numbers.replaceAll(".", "");
      numbers = numbers.replaceAll(",", ".");
    } 
    
    if(decimalSeparator == "") {
      regex = RegExp(r'[^0-9]');
      numbers = value.replaceAll(regex, '');
    } else {
      bool removeDots = false; // Just let the last "."
      for(int i = numbers.length - 1; i >= 0; i--) {
        if(removeDots && numbers[i] == ".") {
          numbers = numbers.replaceFirst(".", "");
        }
        if(numbers[i] == ".") {
          removeDots = true;
        }
      }
    }
    double result = double.tryParse(numbers); // double? result = double.tryParse(numbers); // Nullsafety
    return result ?? 0.0;
  }

  /// Returns the double of a currency [value]
  /// 
  /// If it can not return a result, it will returns [invalidReturn]
  /// 
  /// Example: 
  /// ["R\$ 1.250,71", "10.232", "100", "1.000,7", "1,8", "2.300,72", "2,300.72", "2,100,300,700", "2.100.300.700", "2.100,123456", "2,100.123456", "a"]
  /// 
  /// Result from example:
  /// [1250.71, 10232, 100, 1000.7, 1.8, 2300.72, 2300.72, 2100300700, 2100300700, 2100.123456, 2100.123456, 0.0]
  static double fromCurrencyToDouble(
    String value, 
    {double invalidReturn = 0.0,
  }) {
    RegExp regex = RegExp(r'[^0-9.,]');
    String numbers = value?.replaceAll(regex, '');
    if(numbers == null || numbers == "") {
      return invalidReturn;
    }
    
    String _getFromLastCharacters(String value, {int last = 3}) {
      int i = value.length - 1;
      bool hasValidSeparator = false;
      for(; i >= value.length - last && i > 0; i--) {
        if(value[i] == "." || value[i] == ",") {
          hasValidSeparator = true;
          break;
        }
      }
      if(!hasValidSeparator) {
        return removerCharacters(value, ",.");
      }
      String firstPart = removerCharacters(
        value.substring(0, i), 
        ",.",
      );
      String lastPart = removerCharacters(
        value.substring(i, value.length), 
        ",.",
      );
      
      if(firstPart == "" && lastPart == "") {
        return "";
      } else if(firstPart == "") {
        return lastPart;
      } else if(lastPart == "") {
        return firstPart;
      }
      value = "$firstPart.$lastPart";
      return value;
    }
    
    if(numbers.contains(".") && numbers.contains(",")) {
      String lastSeparator;
      int lastSeparatorQuantity = 0;
      for(int i = numbers.length - 1; i >= 0; i--) {
        if(lastSeparator == null) {
          if(numbers[i] == "." || numbers[i] == ",") {
            lastSeparator = numbers[i];
          }
        }
        if(lastSeparator == numbers[i]) {
          lastSeparatorQuantity++;
        }
      }
      if(lastSeparatorQuantity == 1) {
        numbers = _getFromLastCharacters(numbers, last: numbers.length);
      } else {
        numbers = _getFromLastCharacters(numbers);
      }
    } else if(numbers.contains(".") || numbers.contains(",")){
      numbers = _getFromLastCharacters(numbers);
    }
    return double.tryParse(numbers) ?? invalidReturn;
  }

  /// Remove from [value] the characters passed on [removedCharacters]
  /// 
  /// [useTrim] to use .trim() method on [value]
  static String removerCharacters(
    String value, 
    String removedCharacters,
    {bool useTrim = true,
  }) {
    if(value == null) {
      return standardReturnOfNullValue;
    }

    if(useTrim) {
      value = value.trim();
    }

    if(removedCharacters != null) {
      for(int i = 0; i < removedCharacters.length; i++) {
        value = value.replaceAll(removedCharacters[i], "");
      }
    }

    return value;
  }

  /// Remove accents and ponctuation from [value]
  ///
  /// [removedPonctuation] are the characters that will be removed (it can be *null*)
  /// 
  /// [removeDoubleSpaces] is to remove duplicated spaces
  /// 
  /// [useTrim] is to use .trim() method on [value]
  ///
  /// [useLowerCase] is to use .toLowerCase() method on [value]
  static String removeAccentAndPonctuation(
    String value,
    {String removedPonctuation = ",.!?;:()[]{}}",
    bool removeDoubleSpaces = true,
    bool useTrim = true,
    bool useLowerCase,
    bool useUpperCase,
    String invalidReturn = "",
  }) {
    if(value == null) { // if(!(value is String)) { ... }
      return invalidReturn ?? standardReturnOfNullValue;
    }

    if(useTrim) {
      value = value.trim();
    }

    if(useLowerCase == true) {
      value = value.toLowerCase();
    } else if(useUpperCase == true) {
      value = value.toUpperCase();
    }

    List<Map<String, String>> values = [
      {
        "to": "a",
        "from": "áàãâä",
      },
      {
        "to": "e",
        "from": "éèêë",
      },
      {
        "to": "i",
        "from": "íìîï",
      },
      {
        "to": "o",
        "from": "óòôõö",
      },
      {
        "to": "u",
        "from": "úùûü",
      },
      {
        "to": "y",
        "from": "ýÿ",
      },
      {
        "to": "c",
        "from": "ç",
      },
      {
        "to": "n",
        "from": "ñ",
      },
    ];

    for(Map<String, String> map in values) {
      for(int i = 0; i < map["from"].length; i++) {
        value = value.replaceAll(
          map["from"][i], 
          map["to"],
        );
        value = value.replaceAll(
          map["from"][i].toUpperCase(), 
          map["to"].toUpperCase(),
        );
      }
    }
    
    if(removedPonctuation != null && removedPonctuation != "") {
      for(int i = 0; i < removedPonctuation.length; i++) {
        value = value.replaceAll(removedPonctuation[i], " ");
      }
    }

    if(removeDoubleSpaces) {
      while(value.contains("  ")) {
        value.replaceAll("  ", " ");
      }
    }

    return value;
  }

  /// Transforma um [valor] para Real (BR)
  ///
  /// Retorno padrão: *String* (ex: **R$ 1.999,99**)
  ///
  /// [cifraoEsquerda] retorna "R$ " antes do valor
  ///
  /// [valor] pode receber *int*, *double* ou *String*
  ///
  /// [separadorDecimal] (*String*) separador decimal (padrão: *","*)
  ///
  /// [separadorMilhar] (*String*) separador de milhar (padrão: *"."*)
  ///
  /// [ocultarCentavos] (*bool*) para ocultar os centavos caso seja 00
  ///
  /// [itsFree] (*bool*) para retornar [freeWord] se for 0 (se falso, retorna "R$ 0,00")
  ///
  /// Valores aceitáveis: *1.2312* (R$ 1,23), *"100"* (R$ 100,00), *"1.000,7"* (R$ 1.000,70), *15* (R$ 15,00), *"1,8"* (R$ 1,80)
  static String toRealCurrency( // TODO: Remover função (toCurrency() substituiu)
    dynamic valor, 
    {bool cifraoEsquerda = true,
    String separadorDecimal = ",",
    String separadorMilhar = ".",
    bool ocultarCentavos = false,
    bool retornoGratis = true,
  }) {
    valor = valor.toString();
    dynamic tmp;
    String simbolo = cifraoEsquerda ? "R\$ " : "";
    var msk = MoneyMaskedTextController(
      decimalSeparator: separadorDecimal,
      thousandSeparator: separadorMilhar,
      leftSymbol: simbolo,
    );

    if(valor.contains(",") || valor.contains(".")) {
      if(valor.contains(",") && valor.contains(".")) {
        valor = valor.replaceAll(".", "").replaceAll(",", ".");
      } else {
        valor = valor.replaceAll(",", ".");
      }
      tmp = double.tryParse(valor);
    } else {
      tmp = int.tryParse(valor);
    }

    if(tmp.toString() == "null") {
      if(retornoGratis) {
        return freePriceWord;
      } else {
        return msk.text;
      }
    }

    tmp = tmp.toStringAsFixed(2);
    msk.text = tmp;

    if(ocultarCentavos && msk.text.substring(msk.text.length - 2) == "00") {
      String valor = msk.text;
      valor = valor.substring(0, valor.length - 3);
      return valor;
    }

    if(
      msk.text.toString() == "null" ||
      msk.text.toString() == "0${separadorDecimal}00" ||
      msk.text.toString() == "${simbolo}0${separadorDecimal}00"
    ) {
      if(retornoGratis) {
        return freePriceWord;
      } else {
        return msk.text;
      }
    }

    return msk.text;
  }

  /// It converts to currency the numbers (int or double), strings, etc
  /// 
  /// [leftSymbol] is the symbol before the [value] returned as currency
  /// 
  /// [rightSymbol] is the symbol after the [value] returned as currency
  /// 
  /// If [hideCentsWhenZero] is true and the cents is 0, it returns without cents
  /// 
  /// If [returnFreePriceWord] is true and the result of [value] is 0, it returns [freePriceWord]
  /// 
  /// [precision] is the precision of the decimal places
  /// 
  /// [removeRightDecimalZeros] is to remove right zeros (*1.10* -> *1.1*)
  /// 
  /// Example:
  /// ["432816", "000000", "000", 0, "aaa123", 12345678, 1.2312, "100", "1.000,7", 15, "1,8", 0.185, 1.0001, "R\$ 1.200,9", "R\$ 9,200.6", null]
  /// 
  /// Result from example (standard values):
  /// ["R\$ 432.816,00", freePriceWord, freePriceWord, freePriceWord, "R\$ 123,00", "R\$ 12.345.678,00", "R\$ 1,23", "R\$ 100,00", "R\$ 1000,70", "R\$ 15,00", "R\$ 1,80", "R\$ 0,18", "R\$ 1,00", "R\$ 1.200,90", "R\$ 9.200,60", freePriceWord]
  static String toCurrency(
    dynamic value, 
    {String leftSymbol = "R\$ ",
    String rightSymbol = "",
    String decimalSeparator = ",",
    String thousandSeparator = ".",
    int precision = 2,
    bool hideCentsWhenZero = false,
    bool returnFreePriceWord = true,
    bool removeRightDecimalZeros = false,
  }) {
    dynamic result;
    RegExp regexNumbers = RegExp(r'[^0-9,.]');
    String numbers = value.toString().replaceAll(regexNumbers, '');
    if(removeRightDecimalZeros) {
      hideCentsWhenZero = true;
    }
    
    if(numbers != "") {
      if(numbers.contains(",") || numbers.contains(".")) {
        if(numbers.contains(",") && numbers.contains(".")) {
          String lastSeparator;
          for(int i = numbers.length - 1; i >= 0; i--) {
            if(numbers[i] == "." || numbers[i] == ",") {
              lastSeparator = numbers[i];
              break;
            }
          }
          if(lastSeparator == ".") {
            numbers = numbers.replaceAll(",", "");
          } else {
            numbers = numbers.replaceAll(".", "");
          }
        }
        numbers = numbers.replaceAll(",", ".");
        List<String> separated = numbers.split(".");
        numbers = "";
        for(int i = 0; i < separated.length; i++) {
          if(i == separated.length - 1) {
            numbers = numbers + "." + separated[i];
          } else {
            numbers = numbers + separated[i];
          }
        }
        result = double.tryParse(numbers);
      } else {
        result = int.tryParse(numbers);
      }
      result = result?.toStringAsFixed(precision) ?? "0." + "0" * precision;
    } else {
      result = "0." + "0" * precision;
    }
    
    if(double.tryParse(result) == 0 && returnFreePriceWord) {
      return freePriceWord ?? "";
    } else {
      List<String> separated = result.split(".");
      if(precision <= 0) {
        decimalSeparator = "";
      } else {
        if(hideCentsWhenZero && double.tryParse(separated[1]) == 0) {
          result = separated[0];
          precision = 0;
          decimalSeparator = "";
        }
      }
    }

    if(removeRightDecimalZeros && result.contains(".")) {
      RegExp lastZeros = RegExp(r'0+$');
      if(lastZeros.hasMatch(result)) {
        result = result.replaceAll(lastZeros, "");
        precision = result.split(".")[1].length;
      }
    }
    
    final mask = MoneyMaskedTextController(
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      leftSymbol: leftSymbol,
      rightSymbol: rightSymbol,
      precision: precision,
    );
    mask.text = result;
    return mask.text;
  }
  
  /// It returns a [quantity] of words from [value]
  static String numberOfWords(
    String value, 
    {int quantity = 1,
  }) {
    List<String> values = value?.split(" ");
    String returned = "";
    for(int i = 0; i < quantity && i < values.length; i++) {
      returned += values[i];
      if(i + 1 != quantity && i + 1 != values.length) {
        returned += " ";
      }
    }
    return returned;
  }

  /// It returns based on the day of the [dateTime]:
  /// 
  /// Yesterday: [yesterdayWord]; 
  /// Today: [todayWord]; 
  /// Tomorrow: [tomorrowWord]; 
  /// From tomorrow until 6 days later: Day of the week ([weekDaysStartSunday]); 
  /// Else: [dateTime] in the format [elseDateFormat]
  static String dayFromDateTime(
    DateTime dateTime,
    {String elseDateFormat = "dd/MM/yyyy",
  }) {
    final DateTime now = DateTime.now().toLocal();
    final DateTime nowDay = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final DateTime dateTimeDay = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
    final int difference = dateTimeDay.difference(nowDay).inDays;

    if(difference == -1) {
      return yesterdayWord;
    } else if(difference == 0) {
      return todayWord;
    } else if(difference == 1) {
      return tomorrowWord;
    } else if(difference > 1 && difference < 7) {
      return "${weekDaysStartSunday[dateTime.weekday % 7]}";
    } else {
      return "${DateFormat(elseDateFormat).format(dateTime)}";
    }
  }

  /// It returns the quantity of [character]s in [value]
  static int countCharacters(
    String value, 
    String character,
  ) {
    if(value == null || character == null) {
      return 0;
    }
    return character.allMatches(value).length;
  }

  
  /// Returns the quantity of days, hours and minutes based on [d]
  /// 
  /// If [d] is < 1 minute, it returns ""
  /// 
  /// [returnOnlyOneField] to return only the most important field
  /// 
  /// [abbreviated] to return: "1d, 2h and 1m"
  /// 
  /// [simplified] to return: "1d02h01m" or "2h01"
  /// 
  /// [hideSeparator] is to hide the separator space (" ") between the fields
  static String dHM(
    Duration d, 
    {bool returnOnlyOneField = false,
    bool abbreviated = false,
    bool hideSeparator = false,
    bool simplified = false,
  }) {
    String _phrase(int number, String unityType) {
      String result = "$number";
      if(abbreviated) result += "${unityType[0]}";
      else if(number > 1) result += " ${unityType}s";
      else result += " $unityType";
      return result;
    }
    
    if(simplified) {
      abbreviated = true;
      hideSeparator = true;
    }
    
    List<String> fields = [];
    String result = ""; // Standard value = ""
    if(d.inDays > 0) {
      fields.add(_phrase(d.inDays, dayWord));
      d = Duration(
        minutes: d.inMinutes - Duration(days: d.inDays).inMinutes,
      );
    }
    if(d.inHours > 0) {
      fields.add(_phrase(d.inHours, hourWord));
      d = Duration(
        minutes: d.inMinutes - Duration(hours: d.inHours).inMinutes,
      );
    }
    if(d.inMinutes > 0) {
      fields.add(_phrase(d.inMinutes, minuteWord));
    }
    
    if(fields.isEmpty) return result;
    if(returnOnlyOneField) return fields[0];
    result = "";
    
    for(int i = 0; i < fields.length; i++) {
      result += fields[i];
      if(!hideSeparator) {
        if(i + 2 == fields.length) result += " $andWord ";
        else if(i + 2 < fields.length) result += ", ";
      } else if (i + 1 < fields.length){
        String numbers = fields[i + 1].replaceAll(
          RegExp(r'[^0-9]'),
          "",
        );
        bool addZero = numbers.length < 2;
        if(i + 1 != fields.length && addZero) {
          result += "0";
        }
      }
    }
    if(
      simplified &&
      fields.length > 1 &&
      result[result.length - 1] == minuteWord[0] &&
      result.contains(hourWord[0]) &&
      !result.contains(dayWord[0])
    ) {
      result = result.substring(0, result.length - 1);
    }
    
    return result;
  }
  /*
  print("Example:");
  List<Duration> list = [
    Duration(days: 1, hours: 2, minutes: 1),
    Duration(days: 1, minutes: 1),
    Duration(days: 1, hours: 2),
    Duration(hours: 2, minutes: 3),
    Duration(hours: 2),
    Duration(days: 1),
    Duration.zero,
  ];
  list.forEach((element) {
    print("$element");
    print("(normal):             ${dHM(element)}");
    print("(returnOnlyOneField): ${dHM(element, returnOnlyOneField: true)}");
    print("(abbreviated):        ${dHM(element, abbreviated: true)}");
    print("(simplified):         ${dHM(element, simplified: true)}\n");
  });
  */

  /// Return the bottom and top limit based on a Duration [d]
  /// 
  /// Example: "from 55m until 1h05"
  static String bottomAndTopLimit(Duration d) {
    Duration dBottomLimit = Duration(
      minutes: d.inMinutes - bottomLimitInMinutes,
    );
    Duration dTopLimit = Duration(
      minutes: d.inMinutes + topLimitInMinutes,
    );
    return "$fromWord ${
      dHM(dBottomLimit, simplified: true)
    } $untilWord ${
      dHM(dTopLimit, simplified: true)
    }";
  }
  /*
  print("Example:");
  List<Duration> list = [
    Duration(minutes: 60),
    Duration(minutes: 119),
    Duration(minutes: 120),
    Duration(minutes: 240),
  ];
  list.forEach((element) {
    print("$element: ${b(element)}");
  });
  */

  // TODO: Make comments
  static String durationLimits(Duration d){
    Duration bottom = Duration(minutes: 5);
    Duration top = Duration(minutes: 5);
    Duration inferiorLimit;
    Duration superiorLimit;
    if(d.compareTo(Duration(minutes: 10)) < 0) {
      inferiorLimit = Duration(minutes: 10);
      superiorLimit = Duration(minutes: inferiorLimit.inMinutes + bottom.inMinutes + top.inMinutes);
    } else if(
      d.compareTo(Duration(minutes: 60 - top.inMinutes)) <= 0
    ) {
      inferiorLimit = Duration(minutes: d.inMinutes - bottom.inMinutes);
      superiorLimit = Duration(minutes: d.inMinutes + top.inMinutes);
    } else {
      return dHM(d, abbreviated: true);
    }
    return "${inferiorLimit.inMinutes} ${minuteWord.substring(0, 3)} - ${superiorLimit.inMinutes} ${minuteWord.substring(0, 3)}";
  }

  // TODO: Make comments
  static String uriToText(String uri) {
    if(uri == null) {
      return "";
    } else if(uri.contains("%")) {
      return Uri.decodeFull(uri);
    } else {
      return uri;
    }
  }
}
