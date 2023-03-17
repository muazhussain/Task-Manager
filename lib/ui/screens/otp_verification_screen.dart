import 'package:flutter/material.dart';
import 'package:flutter_03/ui/screens/login_screen.dart';
import 'package:flutter_03/ui/screens/reset_password_screen.dart';
import 'package:flutter_03/ui/widgets/app_elevated_button.dart';
import 'package:flutter_03/ui/widgets/login_singup_navigaton.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_03/utils/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PIN Verification',
                  style: screenTitleTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Enter the 6 digit pin here',
                  style: subtitleTextStyle,
                ),
                const SizedBox(
                  height: 24,
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
                  controller: TextEditingController(),
                  onCompleted: (v) {},
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                AppElevatedButton(
                  child: const Text('Verify'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ),
                      (route) => false,
                    );
                  },
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
    );
  }
}
