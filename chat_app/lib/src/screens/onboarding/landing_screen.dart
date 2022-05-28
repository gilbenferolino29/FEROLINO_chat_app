import 'package:chat_app/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app/src/screens/authentication/auth_screen.dart';

import 'package:chat_app/src/service_locators.dart';
import 'package:flutter/material.dart';

import '../../global/constants.dart';
import '../../global/styles.dart';
import '../../model/landing_data.dart';
import '../../size_configs.dart';
import 'register_screen.dart';

class LandingScreen extends StatefulWidget {
  static const String route = 'landing-screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final NavigationService nav = locator<NavigationService>();

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
        margin: const EdgeInsets.only(right: 10),
        duration: const Duration(milliseconds: 200),
        height: 10,
        width: currentPage == index ? 24 : 15,
        decoration: ShapeDecoration(
            color: currentPage == index ? kPrimaryColor : kSecondaryColor3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: sizeV * 3),
            Text(
              'G-Chat',
              style: kTop,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() {
                  currentPage = value;
                }),
                itemCount: landingContents.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: sizeV * 5),
                    Container(
                        height: sizeV * 35,
                        child: Image.asset(landingContents[index].image)),
                    SizedBox(height: sizeV * 3),
                    Text(
                      landingContents[index].title,
                      style: kTitle,
                    ),
                    SizedBox(height: sizeV * 2),
                    Text(
                      landingContents[index].desc,
                      style: kDesc,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  landingContents.length, (index) => dotIndicator(index)),
            ),
            SizedBox(height: sizeV * 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kSecondaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 75),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                print('Get Started');
                nav.pushNamed(RegisterScreen.route);
              },
              child: Text('Get Started', style: kTitle),
            ),
            SizedBox(height: sizeV * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already Have an Account?',
                  style: kDesc,
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    nav.pushReplacementNamed(AuthScreen.route);
                  },
                  child: Text(
                    'Log in',
                    style: kDesc2,
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeV * 6),
          ],
        ),
      ),
    );
  }
}
