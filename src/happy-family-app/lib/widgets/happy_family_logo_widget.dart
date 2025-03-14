import 'package:flutter/material.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HappyFamilyLogo extends StatelessWidget {
  const HappyFamilyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/logo.png", height: 100),
        Text(AppConstants.appName, style: GoogleFonts.poppins(fontSize: 24)),
      ],
    );
  }
}

class HappyFamilyLogoAppBar extends StatelessWidget {
  const HappyFamilyLogoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/logo.png', height: 40),
        const SizedBox(width: 10),
        const Text(AppConstants.appName),
      ],
    );
  }
}
