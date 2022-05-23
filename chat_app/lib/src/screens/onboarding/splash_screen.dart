import 'dart:async';

import 'package:chat_app/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app/src/screens/onboarding/landing_screen.dart';
import 'package:chat_app/src/service_locators.dart';

import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const String route = 'splash-screen';
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NavigationService nav = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 3),
    //     () => nav.pushReplacementNamed(LandingScreen.route));
    startTime();
  }

  startTime() async {
    return (Timer(const Duration(seconds: 3), route));
  }

  route() {
    nav.pushReplacementNamed(LandingScreen.route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.blueAccent.withOpacity(0.5), BlendMode.dstATop),
              image: const AssetImage('assets/gifs/background.gif'),
              repeat: ImageRepeat.repeat),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'G-Chat',
                  style: GoogleFonts.poppins(
                      color: Color.fromRGBO(27, 59, 154, 1),
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 5),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Text(
                  'Ferolino MobileDev',
                  style: GoogleFonts.poppins(
                      color: Color.fromRGBO(71, 97, 173, 0.9),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
