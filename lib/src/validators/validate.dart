import 'package:cpfcnpj/cpfcnpj.dart';
import '../functions/format.dart';
// pubspec.yaml
// dependencies:
//   cpfcnpj: ^1.0.3

class OwValidate {
  const OwValidate._();

  static final int MAX_CHARACTERS = 255;

  /// [false] se [valor] é vazio; ou <= a [tamanho]; ou > [maxTamanho]
  ///
  /// Se [valor] for uma *String* "null", retornará [false]
  static bool texto(dynamic valor, {int tamanho = 0, int maxTamanho}) {
    if (valor.toString() == "null" || valor.length <= tamanho) return false;
    if (maxTamanho != null && valor.length > maxTamanho)
      return false;
    else
      return true;
  }

  /// Verifica se [valor] é vazio; ou <= a [tamanho]; ou > [maxTamanho]
  static bool lista(List valor, {int tamanho = 0, int maxTamanho}) {
    if (valor.toString() == "null" || valor.length <= tamanho) return false;
    if (maxTamanho != null && valor.length > maxTamanho)
      return false;
    else
      return true;
  }

  /// Valida o nome
  static bool nome(String valor) {
    if (valor == null) return false;
    if (valor.length < 6 || valor.length > MAX_CHARACTERS) return false;
    if (valor.contains("\n") || valor.contains("  ")) return false;
    final regex = RegExp(
        r"^([a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{2,}\s[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{1,}'?-?[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{1,}\s?([a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ'\s]{1,})?)$");
    return regex.hasMatch(valor);
  }

  /// Valida o email
  static bool email(String valor) {
    if (valor == null) return false;
    final Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern);
    return regex.hasMatch(valor);
  }

  /// Valida CPF e CNPJ
  static bool cpfCnpj(String valor) {
    if (valor == null) return false;
    return (CPF.isValid(valor) || CNPJ.isValid(valor));
  }

  /// Valida apenas CPF
  static bool cpf(String valor) {
    if (valor == null) return false;
    return CPF.isValid(valor);
  }

  /// Valida apenas CNPJ
  static bool cnpj(String valor) {
    if (valor == null) return false;
    return CNPJ.isValid(valor);
  }

  /// Valida a senha (tamanho deve ser maior que 5)
  static bool senha(String valor) {
    if (valor == null || valor.length > MAX_CHARACTERS) return false;
    return texto(valor, tamanho: 5);
  }

  /// Valida o número de telefone
  ///
  /// Após remover os caracteres ["+() -"], valida se restou apenas números
  ///
  /// Deve ser entre 8 e 19 caracteres no total (de "00000000" à "+00 (00) 00000 0000")
  static bool telefone(String valor) {
    if (valor == null) return false;
    if (valor.length < 8 || valor.length > 19) return false;
    valor = OwFormat.removerCaracteres(valor, "+() -");
    RegExp regex = RegExp(r'[^0-9]{1}');
    for (int i = 0; i < valor.length; i++) {
      if (regex.hasMatch(valor[i])) return false;
    }
    return true;
  }
}
