enum TextFieldMaskType {
  cpf,
  cnpj,
  cpfCnpj,
  date,
  cardNumber,
  cardCvv,
  cardDateYYYY,
  cardDateYY,
  money,
  integer,
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
  final int numbersQuantity;
  final int minNumbersQuantity;
  final int maxNumbersQuantity;
  // final String constructorCalled; // constructorCalled = "phone";
  
  const TextFieldType(
    TextFieldMaskType type,
  ) : type = type,
      numbersQuantity = null,
      minNumbersQuantity = null, 
      maxNumbersQuantity = null;
  
  
  const TextFieldType.phones({
    int numbersQuantity,
    int minNumbersPhoneQuantity, 
    int maxNumbersPhoneQuantity,
  }): assert(minNumbersPhoneQuantity < maxNumbersPhoneQuantity),
      assert(numbersQuantity == null || (minNumbersPhoneQuantity == null && maxNumbersPhoneQuantity == null)),
      type = TextFieldMaskType.phones, 
      numbersQuantity = numbersQuantity,
      minNumbersQuantity = minNumbersPhoneQuantity, 
      maxNumbersQuantity = maxNumbersPhoneQuantity;
  
  const TextFieldType.cpfCnpj()
    : type = TextFieldMaskType.cpfCnpj,
      numbersQuantity = null,
      minNumbersQuantity = null, 
      maxNumbersQuantity = null;

  const TextFieldType.landlineCell()
    : type = TextFieldMaskType.landlineCell,
      numbersQuantity = null,
      minNumbersQuantity = null, 
      maxNumbersQuantity = null;
  
  // const TextFieldType.integer({
  //   int minNumberOfPlaces = 1,
  //   int maxNumberOfPlaces,
  // }): assert(minNumberOfPlaces < 0), // Ou assert(minNumberOfPlaces < 1),
  //     assert(minNumberOfPlaces < maxNumberOfPlaces),
}

class TextFieldTypes {
  TextFieldTypes._();
  
  static const TextFieldType cpf = TextFieldType(TextFieldMaskType.cpf);
  static const TextFieldType cnpj = TextFieldType(TextFieldMaskType.cnpj);
  static const TextFieldType date = TextFieldType(TextFieldMaskType.date);
  static const TextFieldType cardNumber = TextFieldType(TextFieldMaskType.cardNumber);
  static const TextFieldType cardCvv = TextFieldType(TextFieldMaskType.cardCvv);
  static const TextFieldType cardDateYYYY = TextFieldType(TextFieldMaskType.cardDateYYYY);
  static const TextFieldType cardDateYY = TextFieldType(TextFieldMaskType.cardDateYY);
  static const TextFieldType money = TextFieldType(TextFieldMaskType.money);
  static const TextFieldType integer = TextFieldType(TextFieldMaskType.integer); // ?
  static const TextFieldType name = TextFieldType(TextFieldMaskType.name);
  static const TextFieldType email = TextFieldType(TextFieldMaskType.email);
  static const TextFieldType password = TextFieldType(TextFieldMaskType.password);
  static const TextFieldType multiText = TextFieldType(TextFieldMaskType.multiText);
  static const TextFieldType cep = TextFieldType(TextFieldMaskType.cep);
  static const TextFieldType search = TextFieldType(TextFieldMaskType.search);
  static const TextFieldType chat = TextFieldType(TextFieldMaskType.chat);
  static const TextFieldType landlineCell = TextFieldType(TextFieldMaskType.landlineCell);
}
