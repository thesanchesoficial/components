import 'package:components_venver/material.dart';

class OwValidRequest {
  
  static Future<Map<String, dynamic>> valid(
    dynamic function, 
    {bool showLoading = false, 
    Function beforeRequest, 
    Function afterRequest,
  }) async {
    if(showLoading) OwBotToast.loading(); // show loading
    await beforeRequest(); // run funcions before api
    Map<String, dynamic> retornoApi = await function; // call api
    await afterRequest(); // run funcions after api
    OwBotToast.close(); // close all loading
    return retornoApi; // return result api
  }

  static tryParse(dynamic map) {
    if(map is Map) return map;
    Map<String, dynamic> returnTemp;
    if(map == null) {
      returnTemp = {"error" : "It is null"};
    } else {
      returnTemp = {"success" : map ?? "empty"};
    }
    return returnTemp;
  }
}