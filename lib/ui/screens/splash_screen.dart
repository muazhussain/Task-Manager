import 'package:flutter/material.dart';
import 'package:flutter_03/data/auth_utils.dart';
import 'package:flutter_03/ui/screens/login_screen.dart';
import 'package:flutter_03/ui/screens/main_botton_nav_bar.dart';
import 'package:flutter_03/ui/widgets/screen_background.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then(
      (value) => checkUserAuthState(),
    );
    super.initState();
  }

  void checkUserAuthState() async {
    final bool result = await AuthUtils.checkLoginState();
    await AuthUtils.getAuthDate();
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainBottonNavBar()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset('./assets/images/logo.svg',
              fit: BoxFit.scaleDown),
        ),
      ),
    );
  }
}
