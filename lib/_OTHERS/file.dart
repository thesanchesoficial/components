bool isValidDate(String input) {
  String temp = stringToDateTime(input);
  final date = DateTime.parse(temp);
  final originalFormatString = toOriginalFormatString(date);
  return temp == originalFormatString;
}

String stringToDateTime(String input) {
  input = input.replaceAll("-", "");
  String dia = input.substring(0, 2);
  String mes = input.substring(2, 4);
  String ano = input.substring(4);
  return "$ano$mes$dia";
}

bool validAge(String input) {
  String temp = stringToDateTime(input);
  final date = DateTime.parse(temp);
  if(date.isAfter(DateTime.now().subtract(Duration(days: 4380)))) {
    return false;
  }
  return true;
}

String toOriginalFormatString(DateTime dateTime) {
  final y = dateTime.year.toString().padLeft(4, '0');
  final m = dateTime.month.toString().padLeft(2, '0');
  final d = dateTime.day.toString().padLeft(2, '0');
  return "$y$m$d";
}