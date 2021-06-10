enum TextFieldMaskType {
  cpf,
  cnpj,
  cpfCnpj,
  date,
  dateTime,
  time,
  cardNumber,
  cardCvv,
  cardDateYYYY,
  cardDateYY,
  money,
  integer,
  decimal,
  name,
  email,
  password,
  multiText,
  cep,
  search,
  chat,
  phones,
  landlineCell,
}

class TextFieldType {
  final TextFieldMaskType type;
  final int quantity;
  final num min;
  final num max;
  final List<bool> activatedItemsList;
  final String mask;
  
  const TextFieldType(
    TextFieldMaskType type,
  ) : type = type,
      quantity = null,
      min = null, 
      max = null,
      mask = null,
      activatedItemsList = null;

  const TextFieldType.phones({
    int numbersQuantity,
    int minNumbersPhoneQuantity, 
    int maxNumbersPhoneQuantity,
  }): assert(minNumbersPhoneQuantity < maxNumbersPhoneQuantity),
      assert(numbersQuantity == null || (minNumbersPhoneQuantity == null && maxNumbersPhoneQuantity == null)),
      type = TextFieldMaskType.phones, 
      quantity = numbersQuantity,
      min = minNumbersPhoneQuantity, 
      max = maxNumbersPhoneQuantity,
      mask = null,
      activatedItemsList = null;

  const TextFieldType.cpfCnpj()
    : type = TextFieldMaskType.cpfCnpj,
      quantity = null,
      min = null, 
      max = null,
      mask = null,
      activatedItemsList = null;

  const TextFieldType.landlineCell()
    : type = TextFieldMaskType.landlineCell,
      quantity = null,
      min = null, 
      max = null,
      mask = null,
      activatedItemsList = null;

  const TextFieldType.integer({
    int zerosQuantity = 1,
    int maxNumberOfPlaces = 9,
  }): assert(zerosQuantity > 0),
      assert(zerosQuantity <= maxNumberOfPlaces),
      type = TextFieldMaskType.integer,
      min = zerosQuantity, 
      max = maxNumberOfPlaces,
      quantity = null,
      mask = null,
      activatedItemsList = null;

  // const TextFieldType.decimal({
  //   int zerosQuantity = 1,
  //   int maxNumberOfPlaces = 9,
  // }): assert(zerosQuantity > 0),
  //     assert(zerosQuantity <= maxNumberOfPlaces),
  //     type = TextFieldMaskType.integer,
  //     min = zerosQuantity, 
  //     max = maxNumberOfPlaces,
  //     quantity = null,
  //     mask = null,
  //     activatedItemsList = null;
  
  TextFieldType.dateTime({
    this.mask = "00/00/0000 00:00:00",
  }): assert(mask != null),
      type = TextFieldMaskType.dateTime,
      min = null,
      max = null,
      quantity = null,
      activatedItemsList = null;
}

class TextFieldTypes {
  TextFieldTypes._();
  
  static const TextFieldType cpf = const TextFieldType(TextFieldMaskType.cpf);
  static const TextFieldType cnpj = const TextFieldType(TextFieldMaskType.cnpj);
  static const TextFieldType date = const TextFieldType(TextFieldMaskType.date);
  static const TextFieldType dateTime = const TextFieldType(TextFieldMaskType.dateTime);
  static const TextFieldType time = const TextFieldType(TextFieldMaskType.time);
  static const TextFieldType cardNumber = const TextFieldType(TextFieldMaskType.cardNumber);
  static const TextFieldType cardCvv = const TextFieldType(TextFieldMaskType.cardCvv);
  static const TextFieldType cardDateYYYY = const TextFieldType(TextFieldMaskType.cardDateYYYY);
  static const TextFieldType cardDateYY = const TextFieldType(TextFieldMaskType.cardDateYY);
  static const TextFieldType money = const TextFieldType(TextFieldMaskType.money);
  static const TextFieldType integer = const TextFieldType(TextFieldMaskType.integer);
  static const TextFieldType decimal = const TextFieldType(TextFieldMaskType.decimal);
  static const TextFieldType name = const TextFieldType(TextFieldMaskType.name);
  static const TextFieldType email = const TextFieldType(TextFieldMaskType.email);
  static const TextFieldType password = const TextFieldType(TextFieldMaskType.password);
  static const TextFieldType multiText = const TextFieldType(TextFieldMaskType.multiText);
  static const TextFieldType cep = const TextFieldType(TextFieldMaskType.cep);
  static const TextFieldType search = const TextFieldType(TextFieldMaskType.search);
  static const TextFieldType chat = const TextFieldType(TextFieldMaskType.chat);
  static const TextFieldType landlineCell = const TextFieldType(TextFieldMaskType.landlineCell);
}
