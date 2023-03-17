import 'package:flutter/material.dart';
import 'package:flutter_03/data/network_utils.dart';
import 'package:flutter_03/ui/screens/login_screen.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/app_text_form_field.dart';
import 'package:flutter_03/ui/widgets/login_singup_navigaton.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/utils/snackbar_message.dart';
import 'package:flutter_03/utils/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      'Join With Us',
                      style: screenTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Email',
                      controller: _emailTEC,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'First Name',
                      controller: _firstNameTEC,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Last Name',
                      controller: _lastNameTEC,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Mobile',
                      controller: _mobileTEC,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Password',
                      obscureText: true,
                      controller: _passwordTEC,
                      validator: (value) {
                        int passLength = value?.length ?? 0;
                        if (passLength < 6) {
                          return 'Enter a valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final result = await NetworkUtils.postMethod(
                            'https://task.teamrabbil.com/api/v1/registration',
                            body: {
                              "email": _emailTEC.text.trim(),
                              "firstName": _firstNameTEC.text.trim(),
                              "lastName": _lastNameTEC.text.trim(),
                              "mobile": _mobileTEC.text.trim(),
                              "password": _passwordTEC.text.trim(),
                              "photo": "demo.photo"
                            },
                          );
                          if (result != null && result['status'] == 'success') {
                            snackbarMessage(
                                context, 'Registration successful!');
                          } else {
                            snackbarMessage(
                                context, 'Registration failed!', true);
                          }
                        }
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const LoginScreen(),
                        //   ),
                        //   (route) => false,
                        // );
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LoginSignupNavigation(
                      statement: 'Have account?',
                      buttonText: 'Log In',
                      function: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
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
        ),
      ),
    );
  }
}
