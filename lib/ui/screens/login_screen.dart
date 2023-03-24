import 'package:flutter/material.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/app_text_field.dart';
import 'package:task_manager/ui/widgets/login_signup_navigation.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/utils/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailETController;
  late final TextEditingController _passwordETController;
  late final GlobalKey<FormState> _formKey;
  bool _inProcess = false;

  @override
  void initState() {
    _emailETController = TextEditingController();
    _passwordETController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailETController.dispose();
    _passwordETController.dispose();
    super.dispose();
  }

  Future<void> logIn() async {
    if (_formKey.currentState!.validate()) {
      _inProcess = true;
      setState(() {});
      final result = await NetworkUtils().postMethod(
        Urls.loginUrl,
        body: {
          "email": _emailETController.text.trim(),
          "password": _passwordETController.text,
        },
      );
      _inProcess = true;
      setState(() {});
      if (result != null && result['status'] == 'success' && mounted) {
        await AuthUtils.saveUserData(
          result['token'],
          result['data']['email'],
          result['data']['firstName'],
          result['data']['lastName'],
          result['data']['mobile'],
          result['data']['photo'],
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/mainBottomNavBar',
          (route) => false,
        );
        _emailETController.clear();
        _passwordETController.clear();
      } else {
        showSnackbarMessage(
          context,
          'Wrong email or password',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: _inProcess
            ? Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) / 2,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.green,
                      ),
                      strokeWidth: 5,
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 34,
                          ),
                          Text(
                            'Get Started With',
                            style: titleTextStyle,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextFieldWidget(
                            hintText: 'Email',
                            controller: _emailETController,
                            validator: (email) {
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email ?? '');
                              if (emailValid) {
                                return null;
                              }
                              return 'Enter valid email';
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AppTextFieldWidget(
                            hintText: 'Password',
                            controller: _passwordETController,
                            obscureText: true,
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
                          AppElevatedButton(
                            onPressed: logIn,
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/emailVerification');
                              },
                              child: const Text(
                                'Forget Password',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          LoginSignupNavigation(
                            statement: 'Don\'t have an account?',
                            buttonText: 'Sign up',
                            function: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/signup',
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
