import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/background.svg',
          fit: BoxFit.cover,
          height: size.height,
          width: size.width,
        ),
        child,
      ],
    );
  }
}
