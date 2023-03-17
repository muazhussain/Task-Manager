import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {
  /// Get Method
  static Future<dynamic> getMethod(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        print('Unauthorized');
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  /// Post Method
  static Future<dynamic> postMethod(String url,
      {Map<String, String>? body, VoidCallback? onUnauthorized}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"content-type": "application/json"},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        onUnauthorized;
      } else {
        print('Something went wrong. Status code ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
