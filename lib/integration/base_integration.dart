import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BaseIntegration {
  static Future<Map<String, dynamic>?> httpRequestObject(String url) async {
    var response = await httpGet(url);
    if (response?.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response!.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      log('Request failed with status: ${response!.statusCode}.');
      return null;
    }
  }

  static Future<Iterable?> httpRequestList(String url) async {
    var response = await httpGet(url);
    if (response?.statusCode == 200) {
      Iterable jsonResponseList = convert.jsonDecode(response!.body);
      return jsonResponseList;
    } else {
      log('Request failed with status: ${response!.statusCode}.');
      return null;
    }
  }

  static Future<http.Response?> httpGet(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      return response;
    } on Exception catch (_) {
      return null;
    }
  }
}
