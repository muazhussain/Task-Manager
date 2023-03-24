import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context, String title,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$title'),
      backgroundColor: isError ? Colors.red : null,
      duration: Duration(
        seconds: 1,
      ),
    ),
  );
}
