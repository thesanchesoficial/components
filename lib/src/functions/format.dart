import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../validators/validate.dart';
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
  


  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturn] if [returnValue] is false
  static String trim(
    String value, 
    String invalidReturn,
    {bool returnValue = false,
  }) {
    if (OwValidate.text(value)) {
      return value.toString().trim();
    } else {
      if (returnValue)
        return value.toString();
      else
        return invalidReturn;
    }
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnName] if [returnValue] is false
  static String name(
    String value, 
    {bool returnValue = false,
  }) {
    return trim(
      value, 
      invalidReturnName, 
      returnValue: returnValue,
    );
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnUrl] if [returnValue] is false
  static String url(
    String value, 
    {bool returnValue = false,
  }) {
    return trim(
      value, 
      invalidReturnUrl, 
      returnValue: returnValue,
    );
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnDescription] if [returnValue] is false
  static String description(
    String value, 
    {bool returnValue = false,
  }) {
    return trim(
      value, 
      invalidReturnDescription, 
      returnValue: returnValue,
    );
  }

  /// Only trim
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnEmail] if [returnValue] is false
  static String email(
    String value, 
    {bool returnValue = false,
  }) {
    return trim(
      value, 
      invalidReturnEmail, 
      returnValue: returnValue,
    );
  }

  /// Verify the quantity of numbers (ignoring others characters) and insert into the mask according to [phoneNumberMasks]
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnPhoneNumber] if [returnValue] is false
  static String phoneNumber(
    String value, 
    {bool returnValue = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    if (valueNumbers.length != 0) {
      phoneNumberMasks?.forEach((element) {
        String elementNumbers = element.toString().replaceAll(
          RegExp(r'[^0-9]'), 
          '',
        );
        if (elementNumbers.length == valueNumbers.length) {
          final result = MaskedTextController(
            mask: element, 
            text: valueNumbers,
          );
          return result.text;
        }
      });
    }
    if (returnValue)
      return value.toString();
    else
      return invalidReturnPhoneNumber;
  }

  /// Use the mask "000.000.000-00" (cpf) or "00.000.000/0000-00" (cnpj)
  /// 
  /// Verify the quantity of numbers (ignoring others characters) and insert into according to the mask
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnCpfCnpj] if [returnValue] is false
  static String cpfCnpj(
    String value, 
    {bool returnValue = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    String mask;
    if (valueNumbers.length == 11) {
      mask = cpfMask;
    } else if (valueNumbers.length == 14) {
      mask = cnpjMask;
    } else {
      if (returnValue)
        return value.toString();
      else
        return invalidReturnCpfCnpj;
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
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnCpf] if [returnValue] is false
  static String cpf(
    String value, 
    {bool returnValue = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    if (valueNumbers.length == 11) {
      final result = MaskedTextController(
        mask: cpfMask, 
        text: valueNumbers,
      );
      return result.text;
    } else {
      if (returnValue)
        return value.toString();
      else
        return invalidReturnCpf;
    }
  }

  /// Use the mask "00.000.000/0000-00"
  ///
  /// Verify the quantity of numbers (ignoring others characters) and insert into according to the mask
  ///
  /// If it's not valid, the return can be the same [value] if [returnValue] is true, or [invalidReturnCnpj] if [returnValue] is false
  static String cnpj(
    String value, 
    {bool returnValue = false,
  }) {
    String valueNumbers = value.toString().replaceAll(
      RegExp(r'[^0-9]'), 
      '',
    );
    if (valueNumbers.length == 11) {
      final result = MaskedTextController(
        mask: cnpjMask, 
        text: valueNumbers,
      );
      return result.text;
    } else {
      if (returnValue)
        return value.toString();
      else
        return invalidReturnCnpj;
    }
  }

  /// Upper case on the first letter, and the rest on lower case
  static String upperFirst(String value) {
    if (value != null) {
      if (value.length > 1) {
        return "${value.substring(0, 1).toUpperCase()}${value.substring(1).toLowerCase()}";
      } else {
        return "${value.toUpperCase()}";
      }
    } else return value ?? value.toString();
  }

  // ! Ver nas funções oq vai retornar se for null, se vai retornar null ou "null"
  /// Upper case on the first letter, and the rest keeps the same
  static String upperFirstKeepRest(String value) {
    if (value != null) {
      if (value.length > 1) {
        return "${value.substring(0, 1).toUpperCase()}${value.substring(1)}";
      } else {
        return "${value.toUpperCase()}";
      }
    } else return value ?? value.toString();
  }

  /// Only upper case
  static String upperCase(String value) {
    return value?.toUpperCase() ?? value.toString();
  }

  /// Only lower case
  static String lowerCase(String value) {
    return value?.toLowerCase() ?? value.toString();
  }

  /// Upper case on the first letter of each word
  static String upperFirstEachWord(String value) {
    if (value != null) {
      List<String> words = value?.split(" ");
      String result = "";
      words?.forEach((element) {
        result += "${upperFirst(value)}";
        if (element != words[words.length - 1])
          result += " ";
      });
      return result;
    } else return value;
  }



  /// TODO: Make comments
  /// Tastado: 
  /// ["R\$ 1.111,01", "1.232", "100", "1.000,7", "15", "1,8", "100.022", "R\$ 1.000,70", "R\$ 2.100.300,70", "2,100,300.70", "2,100,300,700", "2.100.300.700"]
  static double fromCurrencyToDouble(String value) {
    String decimalSeparator = "";
    RegExp regex;
    String numbers;

    if (value.length > 2) {
      decimalSeparator = value.substring(
        value.length - 3,
      ).replaceAll(
        RegExp(r'[^,.]'), 
        '',
      );
    }
    regex = RegExp(r'[^0-9.,]');
    numbers = value.replaceAll(regex, '');

    if (decimalSeparator == ".") {
      numbers = numbers.replaceAll(",", "");
    } else if (decimalSeparator == ",") {
      numbers = numbers.replaceAll(".", "");
      numbers = numbers.replaceAll(",", ".");
    } 
    
    if (decimalSeparator == "") {
      regex = RegExp(r'[^0-9]');
      numbers = value.replaceAll(regex, '');
    } else {
      // Deixar apenas o último .
      for (int i = numbers.length; i > 0; i--) {

      }
    }
    double result = double.tryParse(numbers); // double? result = double.tryParse(numbers); // Nullsafety
    return result ?? 0.0;
  }

  /// Remove from [value] the characters passed on [removedCharacters]
  static String removerCharacters(
    String value, 
    String removedCharacters,
    {bool trim = true,
  }) {
    if (trim) value = value.trim();

    if (removedCharacters != null)
      for (int i = 0; i < removedCharacters.length; i++)
        value = value.replaceAll(removedCharacters[i], "");

    return value;
  }

  /// Remove acentos e pontuações do [termo]
  ///
  /// Para não remover pontuação, passe [pontuacaoRemovida] como *null* ou uma *String* vazia ("")
  /// TODO: Make comments
  static String removerAccentAndPonctuation(
    String value,
    {String removedPonctuation = ",.!?;:()[]{}}",
    bool removeDoubleSpaces = true,
    bool useTrim = true,
  }) {

    value = value.trim().toLowerCase(); // Deixar lowercase mesmo?
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

    for (Map<String, String> map in values) {
      for (int i = 0; i < map["from"].length; i++) {
        value = value.replaceAll(map["from"][i], map["to"]);
      }
    }
    
    if (removedPonctuation != null && removedPonctuation != "")
      for (int i = 0; i < removedPonctuation.length; i++)
        value = value.replaceAll(removedPonctuation[i], " ");

    if (removeDoubleSpaces)
      while (value.contains("  "))
        value.replaceAll("  ", " ");

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
  /// [itsFree] (*bool*) para retornar "Grátis" se for 0 (se falso, retorna "R$ 0,00")
  ///
  /// Valores aceitáveis: *1.2312* (R$ 1,23), *"100"* (R$ 100,00), *"1.000,7"* (R$ 1.000,70), *15* (R$ 15,00), *"1,8"* (R$ 1,80)
  static String toRealCurrency( // TODO: Melhorar função
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
        leftSymbol: simbolo);
    if (valor.contains(",") || valor.contains(".")) {
      if (valor.contains(",") && valor.contains("."))
        valor = valor.replaceAll(".", "").replaceAll(",", ".");
      else
        valor = valor.replaceAll(",", ".");
      tmp = double.tryParse(valor);
    } else {
      tmp = int.tryParse(valor);
    }

    if (tmp.toString() == "null") {
      if (retornoGratis)
        return "Grátis";
      else
        return msk.text;
    }

    tmp = tmp.toStringAsFixed(2);
    msk.text = tmp;

    if (ocultarCentavos && msk.text.substring(msk.text.length - 2) == "00") {
      String valor = msk.text;
      valor = valor.substring(0, valor.length - 3);
      return valor;
    }

    if (msk.text.toString() == "null" ||
        msk.text.toString() == "0${separadorDecimal}00" ||
        msk.text.toString() == "${simbolo}0${separadorDecimal}00") {
      if (retornoGratis)
        return "Grátis";
      else
        return msk.text;
    }

    return msk.text;
  }

  // Criar função pra retornar string da data
  //   Passa o DateTime, se for hoje, retornar só "Hoje", ou só a hora
  //   Ou "Amanhã", ou "Terça" (bool pra trazer o "-feira")
  //   Se passar 6 dias depois, ver se vai retornar "Sábado" ou a data
  //   Se for mais de 7 dias depois, retornar a data

  // Criar função pra retornar apenas os X primeiros nomes (passando o nome como parâmetro)
}
