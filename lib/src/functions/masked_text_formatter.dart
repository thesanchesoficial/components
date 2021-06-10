import 'package:components_venver/src/settings/filter_mask.dart';
import 'package:components_venver/src/settings/mask_type.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OwMaskedFormatter {
  OwMaskedFormatter._();

  static MaskTextInputFormatter cpf({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cpf,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cnpj({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cnpj,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cpfCnpj({String initialText}) {
    if(initialText == null || initialText.length <= MaskType.cpf.length) {
      return MaskTextInputFormatter(
        mask: MaskType.cpf,
        filter: FilterMask.number,
        initialText: initialText,
      );
    } else {
      return MaskTextInputFormatter(
        mask: MaskType.cnpj,
        filter: FilterMask.number,
        initialText: initialText,
      );
    }
  }

  static MaskTextInputFormatter date({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.date,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cep({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cep,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phones(int numbersQuantity, {String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phones(numbersQuantity),
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cardNumber({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cardNumber,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cardCvv({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cardCvv,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cardDateYYYY({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cardDateYYYY,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter cardDateYY({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.cardDateYY,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter integer(int numbersQuantity, {String initialText}) {
    return MaskTextInputFormatter(
      mask: "0" * numbersQuantity,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }
}