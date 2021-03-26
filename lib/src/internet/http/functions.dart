import 'dart:convert';
import 'package:components_venver/src/internet/http/valid.dart';
import 'package:http/http.dart' as http;

class OwApi {
  OwApi._();

  static Future<Map<String, dynamic>> post(
    String url, 
    {Map<String, String> headers, 
    Map<String, dynamic> body,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.tryParse(url),
        headers: headers,
        body: jsonEncode(body)
      );
      
      return OwValidRequest.tryParse(jsonDecode(response.body));
    } catch (e) {
      return e;
    }
  }

  static Future<Map<String, dynamic>> put(
    String url, 
    {Map<String, String> headers, 
    Map<String, dynamic> body,
  }) async {
    try {
      http.Response response = await http.put(
        Uri.tryParse(url),
        headers: headers,
        body: jsonEncode(body)
      );
      return OwValidRequest.tryParse(jsonDecode(response.body));
    } catch (e) {
      return e;
    }
  }

  static Future<Map<String, dynamic>> get(
    String url, 
    {Map<String, String> headers,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.tryParse(url),
        headers: headers
      );
      return OwValidRequest.tryParse(jsonDecode(response.body));
    } catch (e) {
      return e;
    }
  }

  static Future<Map<String, dynamic>> delete(
    String url, 
    {Map<String, String> headers, 
  }) async {
    try {
      http.Response response = await http.delete(
        Uri.tryParse(url),
        headers: headers,
      );
      return OwValidRequest.tryParse(jsonDecode(response.body));
    } catch (e) {
      return e;
    }
  }
}