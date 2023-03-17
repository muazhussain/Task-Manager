import 'package:flutter/material.dart';

void snackbarMessage(BuildContext context, String title, [bool error = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: error ? Colors.red : null,
    ),
  );
}
