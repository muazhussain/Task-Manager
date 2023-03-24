import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/app_text_field.dart';
import 'package:task_manager/ui/widgets/login_signup_navigation.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/utils/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailETController;
  late final TextEditingController _firstNameETController;
  late final TextEditingController _lastNameETController;
  late final TextEditingController _mobileETController;
  late final TextEditingController _passwordETController;
  late final GlobalKey<FormState> _formKey;
  bool _inProcess = false;

  @override
  void initState() {
    _emailETController = TextEditingController();
    _firstNameETController = TextEditingController();
    _lastNameETController = TextEditingController();
    _mobileETController = TextEditingController();
    _passwordETController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailETController.dispose();
    _firstNameETController.dispose();
    _lastNameETController.dispose();
    _mobileETController.dispose();
    _passwordETController.dispose();
    super.dispose();
  }

  Future<void> singIn() async {
    if (_formKey.currentState!.validate()) {
      _inProcess = true;
      setState(() {});
      final result = await NetworkUtils().postMethod(
        Urls.registrationUrl,
        body: {
          "email": _emailETController.text.trim(),
          "firstName": _firstNameETController.text.trim(),
          "lastName": _lastNameETController.text.trim(),
          "mobile": _mobileETController.text.trim(),
          "password": _passwordETController.text,
          "photo": "demo.photo"
        },
      );
      _inProcess = false;
      setState(() {});
      if (result != null && result['status'] == 'success') {
        if (mounted) {
          showSnackbarMessage(
            context,
            'Registration successful!',
          );
        }
        _emailETController.clear();
        _firstNameETController.clear();
        _lastNameETController.clear();
        _mobileETController.clear();
        _passwordETController.clear();
      } else {
        if (mounted) {
          showSnackbarMessage(
            context,
            'Something went wrong!',
            true,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: _inProcess
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: AlwaysStoppedAnimation(
                    Colors.green,
                  ),
                  strokeWidth: 5,
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
                            'Join With Us',
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
                            hintText: 'First Name',
                            controller: _firstNameETController,
                            validator: (value) {
                              final bool firstNameValid =
                                  RegExp('[a-zA-Z]').hasMatch(value ?? '');
                              if (firstNameValid) {
                                return null;
                              }
                              return 'Enter valid first name';
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AppTextFieldWidget(
                            hintText: 'Last Name',
                            controller: _lastNameETController,
                            validator: (value) {
                              final bool lastNameValid =
                                  RegExp('[a-zA-Z]').hasMatch(value ?? '');
                              if (lastNameValid) {
                                return null;
                              }
                              return 'Enter valid last name';
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AppTextFieldWidget(
                            hintText: 'Mobile Number',
                            controller: _mobileETController,
                            validator: (value) {
                              final bool mobileValid =
                                  RegExp(r'(^(?:[+0]9)?[0-9]{6,12}$)')
                                      .hasMatch(value ?? '');
                              if (mobileValid) {
                                return null;
                              }
                              return 'Enter valid mobile number';
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
                            onPressed: singIn,
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ),
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
