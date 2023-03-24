import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/app_text_field.dart';
import 'package:task_manager/ui/widgets/login_signup_navigation.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/utils/text_styles.dart';

class ResetPassword extends StatefulWidget {
  final String email, otp;
  ResetPassword({super.key, required this.email, required this.otp});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController _passwordETController1;
  late final TextEditingController _passwordETController2;
  late GlobalKey<FormState> _formKey;
  bool _inProcess = false;

  @override
  void initState() {
    _passwordETController1 = TextEditingController();
    _passwordETController2 = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _passwordETController1.dispose();
    _passwordETController2.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _inProcess = true;
      setState(() {});
      final result = await NetworkUtils().postMethod(
        Urls.resetPasswordUrl,
        body: {
          "email": widget.email,
          "OTP": widget.otp,
          "password": _passwordETController1.text,
        },
      );
      _inProcess = false;
      setState(() {});
      if (result != null && result['status'] == 'success') {
        showSnackbarMessage(
          context,
          'Password changed!',
        );
        Future.delayed(
          Duration(
            seconds: 1,
          ),
        ).then(
          (value) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        );
      } else {
        showSnackbarMessage(
          context,
          'Something went wrong!',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _inProcess
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.yellow,
                            valueColor: AlwaysStoppedAnimation(
                              Colors.green,
                            ),
                            strokeWidth: 5,
                          ),
                        ),
                      ],
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 34,
                          ),
                          Text(
                            'Reset Password',
                            style: titleTextStyle,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Enter a password combination of small, capital & special',
                            style: subtitleTextStyle,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AppTextFieldWidget(
                            obscureText: true,
                            hintText: 'Password',
                            controller: _passwordETController1,
                            validator: (value) {
                              final bool passwordValid = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                                  .hasMatch(value ?? '');
                              if (passwordValid) {
                                return null;
                              }
                              return 'Enter valid password';
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AppTextFieldWidget(
                            obscureText: true,
                            hintText: 'Conform Password',
                            controller: _passwordETController2,
                            validator: (value) {
                              if (_passwordETController1.text !=
                                  _passwordETController2.text) {
                                return 'Password doesn\'t match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AppElevatedButton(
                            child: const Text('Conform'),
                            onPressed: () async {
                              onSubmit();
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          LoginSignupNavigation(
                            statement: 'Already have an account?',
                            buttonText: 'Log In',
                            function: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
