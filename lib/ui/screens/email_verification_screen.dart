import 'package:flutter/material.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/otp_verification_screen.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/app_text_field.dart';
import 'package:task_manager/ui/widgets/login_signup_navigation.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/utils/text_styles.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  late final TextEditingController _emailETController;
  late GlobalKey<FormState> _formKey;
  bool _inProcess = false;

  @override
  void initState() {
    _emailETController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailETController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _inProcess = true;
      setState(() {});
      final result = await NetworkUtils().getMethod(
        Urls.recoveryEmailUrl(
          _emailETController.text.trim(),
        ),
      );
      _inProcess = false;
      setState(() {});
      if (result != null && result['status'] == 'success') {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerification(
                email: _emailETController.text.trim(),
              ),
            ),
          );
        }
      } else {
        showSnackbarMessage(
          context,
          'Something went wrong! Try again!',
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
                    padding: const EdgeInsets.all(34),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 34,
                          ),
                          Text(
                            'Enter Your Email',
                            style: titleTextStyle,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'A 6 digit verification pin will be send to your email address',
                            style: subtitleTextStyle,
                          ),
                          const SizedBox(
                            height: 16,
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
                          AppElevatedButton(
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ),
                            onPressed: () async {
                              onSubmit();
                            },
                          ),
                          const SizedBox(
                            height: 16,
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
