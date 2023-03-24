import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context, String title, [bool? status]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: status ?? false ? Colors.red : null,
      duration: Duration(
        seconds: 1,
      ),
    ),
  );
}
