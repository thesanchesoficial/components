import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  String url;
  Map<String, String> headers;
  Map<String, dynamic> body;
}

class OwApi {
  OwApi._();

  static post(String url, Map<String, String> headers, Map<String, dynamic> body) async {
    try {
      http.Response response = await http.post(Uri.tryParse(url),
        headers: headers,
        body: jsonEncode(body)
      );
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }

  static put(agendamento) async {}

  static get(String id) async {}

  static delete() async {}
}