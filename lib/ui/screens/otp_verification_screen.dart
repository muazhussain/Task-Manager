import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/widgets/app_elevated_button.dart';
import 'package:task_manager/ui/widgets/login_signup_navigation.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/utils/text_styles.dart';

class OtpVerification extends StatefulWidget {
  final String email;
  OtpVerification({super.key, required this.email});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late final TextEditingController _pinETController;
  bool _inProcess = false;

  @override
  void initState() {
    _pinETController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pinETController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    _inProcess = true;
    setState(() {});
    final result = await NetworkUtils().getMethod(
      Urls.otpVerificationUrl(
        widget.email,
        _pinETController.text,
      ),
    );
    _inProcess = false;
    setState(() {});
    if (result != null && result['status'] == 'success') {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassword(
              email: widget.email,
              otp: _pinETController.text,
            ),
          ),
          (route) => false,
        );
      }
    } else {
      showSnackbarMessage(
        context,
        'Something went wrong!',
        true,
      );
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
                    padding: const EdgeInsets.all(34),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          'PIN Verification',
                          style: titleTextStyle,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Enter the 6 digit pin here',
                          style: subtitleTextStyle,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PinCodeTextField(
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeColor: Colors.green,
                            activeFillColor: Colors.white,
                            inactiveColor: Colors.green,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            selectedColor: Colors.amberAccent,
                          ),
                          appContext: context,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.white,
                          enableActiveFill: true,
                          errorAnimationController: null,
                          controller: _pinETController,
                          autoDisposeControllers: false,
                          onCompleted: (v) {},
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppElevatedButton(
                          child: const Text('Verify'),
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
    );
  }
}
