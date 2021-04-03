import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> addressByCoordGoogleMaps(
  dynamic latitude, 
  dynamic longitude,
) async {
  Map<String, dynamic> coordenates = {
    "latitude": latitude.toString(),
    "longitude": longitude.toString(),
  };

  http.Response response = await http.post(
    Uri.tryParse("https://matheussanches.wixsite.com/mysite-12/_functions/coordenada/"),
    body: jsonEncode(coordenates),
  );

  Map<dynamic, dynamic> result = json.decode(response.body);

  Map<String, dynamic> returned = {};
  if(result["code"].toString() == "200") {
    result["endereco"].forEach((element) {
      if(element["types"].contains("postal_code")) {
        returned["cep"] = element["short_name"].replaceAll("-", "");
      } else if(element["types"].contains("street_number")) {
        returned["numero"] = element["long_name"];
      } else if(element["types"].contains("route")) {
        returned["rua"] = element["long_name"];
      } else if(
        element["types"].contains("sublocality") ||
        element["types"].contains("sublocality_level_1")
      ) {
        returned["bairro"] = element["long_name"];
      } else if(element["types"].contains("administrative_area_level_2")) {
        returned["cidade"] = element["long_name"];
      } else if(element["types"].contains("administrative_area_level_1")) {
        returned["estado"] = element["short_name"];
      } else if(element["types"].contains("country")) {
        returned["pais"] = element["long_name"];
      }
    });
    returned["latitude"] = result["coordenadas"]["lat"];
    returned["longitude"] = result["coordenadas"]["lng"];
    returned["formatado"] = result["formatado"];
  } else {
    returned["error"] = "Not found.";
  }

  return returned;
}