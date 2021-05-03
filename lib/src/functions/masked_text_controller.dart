import 'package:components_venver/src/settings/mask_type.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class OwMaskedController {
  OwMaskedController._();

  static const String currencySymbol = "R\$"; // ! Passar pro inicializador

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

  static MaskedTextController phone8({String text}) {
    return MaskedTextController(
      mask: MaskType.phone8,
      text: text,
    );
  }

  static MaskedTextController phone9({String text}) {
    return MaskedTextController(
      mask: MaskType.phone9,
      text: text,
    );
  }

  static MaskedTextController phone10({String text}) {
    return MaskedTextController(
      mask: MaskType.phone10,
      text: text,
    );
  }

  static MaskedTextController phone11({String text}) {
    return MaskedTextController(
      mask: MaskType.phone11,
      text: text,
    );
  }

  static MaskedTextController phone12({String text}) {
    return MaskedTextController(
      mask: MaskType.phone12,
      text: text,
    );
  }

  static MaskedTextController phone13({String text}) {
    return MaskedTextController(
      mask: MaskType.phone13,
      text: text,
    );
  }
  
  static MaskedTextController cardNumber({String text}) {
    return MaskedTextController(
      mask: MaskType.cardNumber,
      text: text,
    );
  }

  static MaskedTextController cvvCard({String text}) {
    return MaskedTextController(
      mask: MaskType.cvvCard,
      text: text,
    );
  }

  static MaskedTextController dateCardYY({String text}) {
    return MaskedTextController(
      mask: MaskType.dateCardYY,
      text: text,
    );
  }

  static MaskedTextController dateCardYYYY({String text}) {
    return MaskedTextController(
      mask: MaskType.dateCardYYYY,
      text: text,
    );
  }

  static MaskedTextController date({String text}) {
    return MaskedTextController(
      mask: MaskType.date,
      text: text,
    );
  }

  static MaskedTextController numbers(int numbersQuantity, {String text}) {
    return MaskedTextController(
      mask: "0" * numbersQuantity,
      text: text,
    );
  }

  static MoneyMaskedTextController money({
    double initialValue = 0.0,
    int precision = 2,
    String leftSymbol = currencySymbol,
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