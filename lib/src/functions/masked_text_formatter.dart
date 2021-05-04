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

  static MaskTextInputFormatter date({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.date,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phone8({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phone8,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phone9({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phone9,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phone10({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phone10,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phone11({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phone11,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phone12({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phone12,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }

  static MaskTextInputFormatter phone13({String initialText}) {
    return MaskTextInputFormatter(
      mask: MaskType.phone13,
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

  static MaskTextInputFormatter numbers(int numbersQuantity, {String initialText}) {
    return MaskTextInputFormatter(
      mask: "0" * numbersQuantity,
      filter: FilterMask.number,
      initialText: initialText,
    );
  }
}