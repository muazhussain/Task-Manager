import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/main.dart';

class NetworkUtils {
  Future<dynamic> getMethod(
    String url, {
    VoidCallback? onUnAuthorized,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'token': AuthUtils.token ?? '',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
      log(response.statusCode.toString());
    } catch (error) {
      log('$error');
    }
  }

  Future<dynamic> postMethod(
    String url, {
    Map<String, String>? body,
    VoidCallback? onUnAuthorized,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtils.token ?? '',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (error) {
      log('$error');
    }
  }

  void moveToLogin() async {
    await AuthUtils.clearData();
    Navigator.pushNamedAndRemoveUntil(
      TaskManagerApp.globalKey.currentContext!,
      '/login',
      (route) => false,
    );
  }
}
