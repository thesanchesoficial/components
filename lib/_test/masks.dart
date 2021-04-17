/*
"0" = Numbers;
"A" = Letters (upper case);
"a" = Letters (lower case);
"x" = Letter (any case);
*/

List<Map<String, dynamic>> masks = [
  {
    "type": "cpf",
    "mask": "000.000.000-00",
  },
  {
    "type": "cnpj",
    "mask": "00.000.000/0000-00",
  },
  {
    "type": "date",
    "mask": "00/00/0000",
  },

  {
    "type": "phone-8",
    "mask": "0000 0000",
  },
  {
    "type": "phone-9",
    "mask": "00000 0000",
  },
  {
    "type": "phone-10",
    "mask": "(00) 0000 0000",
  },
  {
    "type": "phone-11",
    "mask": "(00) 00000 0000",
  },
  {
    "type": "phone-12",
    "mask": "+00 (00) 0000 0000",
  },
  {
    "type": "phone-13",
    "mask": "+00 (00) 00000 0000",
  },
];
