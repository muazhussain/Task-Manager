import 'package:flutter/material.dart';
import 'package:flutter_03/data/auth_utils.dart';
import 'package:flutter_03/data/network_utils.dart';
import 'package:flutter_03/ui/screens/email_verification_screen.dart';
import 'package:flutter_03/ui/screens/main_botton_nav_bar.dart';
import 'package:flutter_03/ui/screens/sign_up_screen.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/app_text_form_field.dart';
import 'package:flutter_03/ui/widgets/login_singup_navigaton.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/utils/snackbar_message.dart';
import 'package:flutter_03/utils/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      final result = await NetworkUtils.postMethod(
        'https://task.teamrabbil.com/api/v1/login',
        body: {
          "email": _emailTEC.text.trim(),
          "password": _passwordTEC.text.trim(),
        },
      );
      if (result != null && result['status'] == 'success') {
        await AuthUtils.saveUserDate(
          result['data']['firstName'],
          result['data']['lastName'],
          result['data']['email'],
          result['data']['mobile'],
          result['data']['photo'],
          result['token'],
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottonNavBar(),
          ),
          (route) => false,
        );
      } else {
        snackbarMessage(
          context,
          'Email or password wrong',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started With',
                  style: screenTitleTextStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                AppTextFieldWidget(
                  controller: _emailTEC,
                  hintText: 'Email',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFieldWidget(
                  controller: _passwordTEC,
                  obscureText: true,
                  hintText: 'Password',
                  validator: (value) {
                    int passLength = value?.length ?? 0;
                    if (passLength < 6) {
                      return 'Enter valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AppElevatedButton(
                  onPressed: login,
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerification(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                LoginSignupNavigation(
                  statement: 'Don\'t have an account?',
                  buttonText: 'Sign Up',
                  function: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
