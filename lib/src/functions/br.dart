import 'package:components_venver/functions.dart';

class Br {
  Br._();

  static const List<Map<String, String>> states = [
    {
      "state": "Acre",
      "uf": "AC",
    },
    {
      "state": "Alagoas",
      "uf": "AL",
    },
    {
      "state": "Amapá",
      "uf": "AP",
    },
    {
      "state": "Amazonas",
      "uf": "AM",
    },
    {
      "state": "Bahia",
      "uf": "BA",
    },
    {
      "state": "Ceará",
      "uf": "CE",
    },
    {
      "state": "Espírito Santo",
      "uf": "ES",
    },
    {
      "state": "Goiás",
      "uf": "GO",
    },
    {
      "state": "Maranhão",
      "uf": "MA",
    },
    {
      "state": "Mato Grosso",
      "uf": "MT",
    },
    {
      "state": "Mato Grosso do Sul",
      "uf": "MS",
    },
    {
      "state": "Minas Gerais",
      "uf": "MG",
    },
    {
      "state": "Pará",
      "uf": "PA",
    },
    {
      "state": "Paraíba",
      "uf": "PB",
    },
    {
      "state": "Paraná",
      "uf": "PR",
    },
    {
      "state": "Pernambuco",
      "uf": "PE",
    },
    {
      "state": "Piauí",
      "uf": "PI",
    },
    {
      "state": "Rio de Janeiro",
      "uf": "RJ",
    },
    {
      "state": "Rio Grande do Norte",
      "uf": "RN",
    },
    {
      "state": "Rio Grande do Sul",
      "uf": "RS",
    },
    {
      "state": "Rondônia",
      "uf": "RO",
    },
    {
      "state": "Roraima",
      "uf": "RR",
    },
    {
      "state": "Santa Catarina",
      "uf": "SC",
    },
    {
      "state": "São Paulo",
      "uf": "SP",
    },
    {
      "state": "Sergipe",
      "uf": "SE",
    },
    {
      "state": "Tocantins",
      "uf": "TO",
    },
    {
      "state": "Distrito Federal",
      "uf": "DF",
    },
  ];

  /// [stateOrUf] can be the state name (BR), or UF (2 letters)
  ///
  /// Returns null if [stateOrUf] is null, or if not found
  static String changeStateUf(String stateOrUf) {
    if(stateOrUf == null) return null;

    String from = "state";
    String to = "uf";
    if(stateOrUf.length == 2) {
      from = "uf";
      to = "state";
    }

    for (Map<String, String> i in states) {
      if(
        OwFormat.removeAccentAndPonctuation(stateOrUf).contains(
          OwFormat.removeAccentAndPonctuation(i[from]),
        )
      ) {
        return i[to];
      }
    }
    return null;
  }
}

