import 'package:flutter/material.dart';

class LoginSignupNavigation extends StatelessWidget {
  const LoginSignupNavigation({
    super.key,
    required this.statement,
    required this.buttonText,
    required this.function,
  });

  final String statement;
  final String buttonText;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(statement),
        TextButton(
          onPressed: function,
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
