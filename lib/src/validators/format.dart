import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'validate.dart';
// pubspec.yaml
// dependencies:
//   flutter_masked_text: ^0.8.0

class MSFormat {
  const MSFormat._();

  static const int MAX_CHARACTERS = 255;

  /// Apenas trim
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna [retornoInvalido]
  static String apenasTrim(String valor, String retornoInvalido, {bool retornoValor = false}) {
    if (MSValidate.texto(valor)) {
      return valor.toString().trim();
    } else {
      if (retornoValor) return valor.toString();
      else return retornoInvalido;
    }
  }

  /// Apenas trim
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem nome"
  static String nome(String valor, {bool retornoValor = false}) {
    return apenasTrim(valor, "Sem nome", retornoValor: retornoValor);
  }

  /// Apenas trim
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem url"
  static String url(String valor, {bool retornoValor = false}) {
    return apenasTrim(valor, "Sem url", retornoValor: retornoValor);
  }

  /// Apenas trim
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem descrição"
  static String descricao(String valor, {bool retornoValor = false}) {
    return apenasTrim(valor, "Sem descrição", retornoValor: retornoValor);
  }

  /// Apenas trim
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem email"
  static String email(String valor, {bool retornoValor = false}) {
    return apenasTrim(valor, "Sem email", retornoValor: retornoValor);
  }

  /// Compara o tamanho e usa as seguintes máscaras: "0000 0000"; "00000 0000"; "(00) 0000 0000"; "(00) 00000 0000"; "+00 (00) 0000 0000"; "+00 (00) 00000 0000"
  ///
  /// Se não for válido, e [retornoValor] for false, retorna "Sem telefone"
  static String numeroTelefone(String valor, {bool retornoValor = false}) {
    String result = valor.toString().replaceAll(RegExp(r'[^0-9]'), '');
    String mask;
    if (result.length == 8) mask = "0000 0000";
    else if (result.length == 9) mask = "00000 0000";
    else if (result.length == 10) mask = "(00) 0000 0000";
    else if (result.length == 11) mask = "(00) 00000 0000";
    else if (result.length == 12) mask = "+00 (00) 0000 0000";
    else if (result.length == 13) mask = "+00 (00) 00000 0000";
    else {
      if (retornoValor) return valor.toString();
      else return "Sem telefone";
    }
    final text = MaskedTextController(mask: mask, text: result);
    return text.text;
  }

  /// Usa a máscara "000.000.000-00" (cpf) ou "00.000.000/0000-00" (cnpj)
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem CPF/CNPJ"
  static String cpfCnpj(String valor, {bool retornoValor = false}) {
    String result = valor.toString().replaceAll(RegExp(r'[^0-9]'), '');
    String mask;
    if(result.length == 11) mask = "000.000.000-00";
    else if(result.length == 14) mask = "00.000.000/0000-00";
    else {
      if (retornoValor) return valor.toString();
      else return "Sem CPF/CNPJ";
    }
    final text = MaskedTextController(mask: mask, text: result);
    return text.text;
  }

  /// Usa a máscara "000.000.000-00"
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem CPF"
  static String cpf(String valor, {bool retornoValor = false}) {
    String result = valor.toString().replaceAll(RegExp(r'[^0-9]'), '');
    String mask;
    if(result.length == 11) mask = "000.000.000-00";
    else {
      if (retornoValor) return valor.toString();
      else return "Sem CPF";
    }
    final text = MaskedTextController(mask: mask, text: result);
    return text.text;
  }

  /// Usa a máscara "00.000.000/0000-00"
  /// 
  /// Se não for válido, e [retornoValor] for false, retorna "Sem CNPJ"
  static String cnpj(String valor, {bool retornoValor = false}) {
    String result = valor.toString().replaceAll(RegExp(r'[^0-9]'), '');
    String mask;
    if(result.length == 11) mask = "00.000.000/0000-00";
    else {
      if (retornoValor) return valor.toString();
      else return "Sem CNPJ";
    }
    final text = MaskedTextController(mask: mask, text: result);
    return text.text;
  }

  /// UpperCase apenas na primeira letra e o resto lowerCase
  static String capsPrimeiro(String valor) {
    String result = valor;
    if(valor != null && valor.length > 1) {
      result = "${valor.substring(0,1).toUpperCase()}${valor.substring(1).toLowerCase()}";
    }
    return result;
  }

  /// UpperCase apenas na primeira letra, o resto continua o mesmo
  static String upperPrimeiroRestoMesmo(String valor) {
    String result = valor;
    if(valor != null && valor.length > 1) {
      result = "${valor.substring(0,1).toUpperCase()}${valor.substring(1)}";
    }
    return result;
  }

  /// Apenas upperCase
  static String upperCase(String valor) {
    return valor.toUpperCase();
  }
  
  /// Apenas lowerCase
  static String lowerCase(String valor) {
    return valor.toLowerCase();
  }

  /// UpperCase para primeira letra de cada palavra
  static String upperPrimeiraLetra(String value) {
    String result = value;
    if(value != null && value.length > 1) {
      List nomes = value.split(" ");
      result = "";
      nomes.forEach((element) {
        result += "${element.substring(0,1).toUpperCase()}${element.substring(1).toLowerCase()} ";
      });
    }
    return result.trim();
  }



  /// Converte para double, pode usar separador de milhar (deve ser diferente do separador decimal)
  /// 
  /// Use "," ou "." como separador decimal
  /// 
  /// Remove todos os caracteres, exceto números, pontos (.) e vírgulas (,)
  /// 
  /// Se não puder converter, retorna 0
  static double deRealParaDouble(String valor){
    double result = double.tryParse(valor.toString());
    String value = valor.toString().replaceAll(RegExp(r'[^0-9,.]'), '');
    if(value.toString() == null) return 0.0;
    String decimalSeparator;
    for(int i = value.length - 1; i >= 0; i--){
      if(decimalSeparator == null && (value[i] == "." || value[i] == ",")){
        decimalSeparator = value[i];
        break;
      }
    }
    if(decimalSeparator == ","){
      value = value.replaceAll(".", "").replaceAll(",", ".");
    }else{
      value = value.replaceAll(",", "");
    }
    result = double.tryParse(value.toString());
    
    return result ?? 0.0;
  }
  

  /// Remove acentos e pontuações do [termo]
  /// 
  /// Para não remover pontuação, passe [pontuacaoRemovida] como *null* ou uma *String* vazia ("")
  static String removerAcentosEPontuacao(String termo, {String pontuacaoRemovida = ",.!?;:()[]{}}"}){
    termo = termo.trim().toLowerCase();
    List a = ["á", "à", "ã", "â", "ä"];
    for(var letra in a)
      termo = termo.replaceAll(letra, "a");
    
    List e = ["é", "è", "ê", "ë"];
    for(var letra in e)
      termo = termo.replaceAll(letra, "e");
    
    List i = ["í", "ì", "î", "ï"];
    for(var letra in i)
      termo = termo.replaceAll(letra, "i");
    
    List o = ["ó", "ò", "ô", "õ", "ö"];
    for(var letra in o)
      termo = termo.replaceAll(letra, "o");
    
    List u = ["ú", "ù", "û", "ü"];
    for(var letra in u)
      termo = termo.replaceAll(letra, "u");
    
    List y = ["ý", "ÿ"];
    for(var letra in y)
      termo = termo.replaceAll(letra, "y");
    
    termo = termo.replaceAll("ç", "c");
    termo = termo.replaceAll("ñ", "n");

    if (pontuacaoRemovida != null && pontuacaoRemovida != "")
      for (int i = 0; i < pontuacaoRemovida.length; i++)
        termo = termo.replaceAll(pontuacaoRemovida[i], " ");

    return termo;
  }

  /// Remove de [valor] os caracteres passados em [caracteres]
  static String removerCaracteres(dynamic valor, String caracteres, {bool trim = true}){
    String msg = valor.toString();
    if(trim) msg = msg.trim();

    for(int i = 0; i < caracteres.length; i++){
      msg = msg.replaceAll(caracteres[i], "");
    }

    return msg;
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
  /// [retornoGratis] (*bool*) para retornar "Grátis" se for 0 (se falso, retorna "R$ 0,00")
  /// 
  /// Valores aceitáveis: *1.2312* (R$ 1,23), *"100"* (R$ 100,00), *"1.000,7"* (R$ 1.000,70), *15* (R$ 15,00), *"1,8"* (R$ 1,80)
  static String paraReal(
    dynamic valor, 
    {bool cifraoEsquerda = true, 
    String separadorDecimal = ",", 
    String separadorMilhar = ".", 
    bool ocultarCentavos = false,
    bool retornoGratis = true,
  }){
    valor = valor.toString();
    dynamic tmp;
    String simbolo = cifraoEsquerda ? "R\$ " : "";
    var msk = MoneyMaskedTextController(decimalSeparator: separadorDecimal, thousandSeparator: separadorMilhar, leftSymbol: simbolo);
    if(valor.contains(",") || valor.contains(".")){
      if(valor.contains(",") && valor.contains(".")) valor = valor.replaceAll(".", "").replaceAll(",", ".");
      else valor = valor.replaceAll(",", ".");
      tmp = double.tryParse(valor);
    }else{
      tmp = int.tryParse(valor);
    }
    
    if(tmp.toString() == "null"){
      if(retornoGratis) return "Grátis";
      else return msk.text;
    }
    
    tmp = tmp.toStringAsFixed(2);
    msk.text = tmp;

    if(ocultarCentavos && msk.text.substring(msk.text.length - 2) == "00"){
      String valor = msk.text;
      valor = valor.substring(0, valor.length - 3);
      return valor;
    }

    if (msk.text.toString() == "null" || 
        msk.text.toString() == "0${separadorDecimal}00" || 
        msk.text.toString() == "${simbolo}0${separadorDecimal}00"
    ){
      if(retornoGratis) return "Grátis";
      else return msk.text;
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