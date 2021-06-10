import 'package:components_venver/src/settings/mask_type.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class OwMaskedController {
  OwMaskedController._();

  static MaskedTextController cpf({String text}) {
    return MaskedTextController(
      mask: MaskType.cpf,
      text: text,
    );
  }

  static MaskedTextController cnpj({String text}) {
    return MaskedTextController(
      mask: MaskType.cnpj,
      text: text,
    );
  }

  static MaskedTextController phones(int numbersQuantity, {String text}) {
    return MaskedTextController(
      mask: MaskType.phones(numbersQuantity),
      text: text,
    );
  }
  
  static MaskedTextController cardNumber({String text}) {
    return MaskedTextController(
      mask: MaskType.cardNumber,
      text: text,
    );
  }

  static MaskedTextController cardCvv({String text}) {
    return MaskedTextController(
      mask: MaskType.cardCvv,
      text: text,
    );
  }

  static MaskedTextController cardDateYY({String text}) {
    return MaskedTextController(
      mask: MaskType.cardDateYY,
      text: text,
    );
  }

  static MaskedTextController cardDateYYYY({String text}) {
    return MaskedTextController(
      mask: MaskType.cardDateYYYY,
      text: text,
    );
  }

  static MaskedTextController date({String text}) {
    return MaskedTextController(
      mask: MaskType.date,
      text: text,
    );
  }

  static MaskedTextController cep({String text}) {
    return MaskedTextController(
      mask: MaskType.cep,
      text: text,
    );
  }

  static MaskedTextController integer(int numbersQuantity, {String text}) {
    return MaskedTextController(
      mask: "0" * numbersQuantity,
      text: text,
    );
  }

  static MoneyMaskedTextController money({
    double initialValue = 0.0,
    int precision = 2,
    String leftSymbol = "",
    String rightSymbol = "",
    String decimalSeparator = ",",
    String thousandSeparator = ".",
  }) {
    if(leftSymbol != null && leftSymbol != "") {
      leftSymbol += " ";
    }
    
    return MoneyMaskedTextController(
      initialValue: initialValue,
      precision: precision,
      decimalSeparator: decimalSeparator,
      leftSymbol: leftSymbol,
      rightSymbol: rightSymbol,
      thousandSeparator: thousandSeparator,
    );
  }
}