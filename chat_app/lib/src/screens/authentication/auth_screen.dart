import 'package:chat_app/src/controllers/auth_controller.dart';
import 'package:chat_app/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app/src/global/constants.dart';
import 'package:chat_app/src/global/styles.dart';
import 'package:chat_app/src/screens/onboarding/home_screen.dart';
import 'package:chat_app/src/screens/onboarding/register_screen.dart';
import 'package:chat_app/src/size_configs.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service_locators.dart';

class AuthScreen extends StatefulWidget {
  static const String route = 'auth-screen';

  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  final AuthController _authController = locator<AuthController>();
  final NavigationService nav = locator<NavigationService>();

  String prompts = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          ///shows a loading screen while initializing
          if (_authController.working) {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              ),
            );
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: sizeH * 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: sizeH * 40.5),
                            Text(
                              'Sign in',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kSecondaryColor),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor3,
                            ),
                          ),
                        ),
                        SizedBox(height: sizeV * 3),
                        Container(
                          height: sizeV * 20,
                          child: Image.asset(
                            'assets/images/g-chat.png',
                          ),
                        ),
                        SizedBox(height: sizeV * 6),
                        Form(
                          key: _formKey,
                          onChanged: () {
                            _formKey.currentState?.validate();
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              children: [
                                Text(_authController.error?.message ?? ''),
                                TextFormField(
                                  style: kDesc,
                                  decoration: InputDecoration(
                                      hintText: 'Username',
                                      focusColor: kPrimaryColor),
                                  controller: _unCon,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: sizeV * 3),
                                TextFormField(
                                  style: kDesc,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                  ),
                                  controller: _passCon,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: sizeV * 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kSecondaryColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 75),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: (_formKey.currentState?.validate() ??
                                  false)
                              ? () {
                                  _authController.login(
                                      _unCon.text.trim(), _passCon.text.trim());
                                }
                              : null,
                          child: Text('Login', style: kTitle),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: sizeV * 5,
                      left: sizeH * 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have an Account?",
                            style: kDesc,
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              nav.pushReplacementNamed(RegisterScreen.route);
                            },
                            child: Text(
                              'SIGN UP',
                              style: kDesc2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            // return Scaffold(

            //   backgroundColor: Colors.grey[400],
            //   body: SafeArea(
            //     child: Center(
            //       child: SingleChildScrollView(
            //         child: Container(
            //           padding: const EdgeInsets.all(16),
            //           child: Center(
            //             child: AspectRatio(
            //               aspectRatio: 4 / 3,
            //               child: Card(
            //                 child: Container(
            //                   padding: const EdgeInsets.all(16),
            //                   child: Center(
            //                     child: Form(
            //                       key: _formKey,
            //                       onChanged: () {
            //                         _formKey.currentState?.validate();
            //                         if (mounted) {
            //                           setState(() {});
            //                         }
            //                       },
            //                       child: Column(
            //                         mainAxisSize: MainAxisSize.min,
            //                         children: [
            //                           Padding(
            //                             padding: const EdgeInsets.all(16),
            //                             child: Text(
            //                                 _authController.error?.message ??
            //                                     ''),
            //                           ),
            //                           TextFormField(
            //                             decoration: const InputDecoration(
            //                                 hintText: 'Email'),
            //                             controller: _unCon,
            //                             validator: (value) {
            //                               if (value == null || value.isEmpty) {
            //                                 return 'Please enter your email';
            //                               }
            //                               return null;
            //                             },
            //                           ),
            //                           TextFormField(
            //                             obscureText: true,
            //                             decoration: const InputDecoration(
            //                               hintText: 'Password',
            //                             ),
            //                             controller: _passCon,
            //                             validator: (value) {
            //                               if (value == null || value.isEmpty) {
            //                                 return 'Please enter your password';
            //                               }
            //                               return null;
            //                             },
            //                           ),
            //                           Flexible(
            //                             child: Padding(
            //                               padding: const EdgeInsets.symmetric(
            //                                   vertical: 32),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceAround,
            //                                 children: [
            //                                   ElevatedButton(
            //                                     onPressed: (_formKey
            //                                                 .currentState
            //                                                 ?.validate() ??
            //                                             false)
            //                                         ? () {
            //                                             _authController.register(
            //                                                 email: _unCon.text
            //                                                     .trim(),
            //                                                 password: _passCon
            //                                                     .text
            //                                                     .trim());
            //                                           }
            //                                         : null,
            //                                     style: ElevatedButton.styleFrom(
            //                                         shape:
            //                                             RoundedRectangleBorder(
            //                                           borderRadius:
            //                                               BorderRadius.circular(
            //                                                   16.0),
            //                                         ),
            //                                         primary: (_formKey
            //                                                     .currentState
            //                                                     ?.validate() ??
            //                                                 false)
            //                                             ? const Color(
            //                                                 0xFF303030)
            //                                             : Colors.grey),
            //                                     child: const Text('Register'),
            //                                   ),
            //                                   ElevatedButton(
            //                                     onPressed: (_formKey
            //                                                 .currentState
            //                                                 ?.validate() ??
            //                                             false)
            //                                         ? () {
            //                                             _authController.login(
            //                                                 _unCon.text.trim(),
            //                                                 _passCon.text
            //                                                     .trim());
            //                                           }
            //                                         : null,
            //                                     style: ElevatedButton.styleFrom(
            //                                         shape:
            //                                             RoundedRectangleBorder(
            //                                           borderRadius:
            //                                               BorderRadius.circular(
            //                                                   16.0),
            //                                         ),
            //                                         primary: (_formKey
            //                                                     .currentState
            //                                                     ?.validate() ??
            //                                                 false)
            //                                             ? const Color(
            //                                                 0xFF303030)
            //                                             : Colors.grey),
            //                                     child: const Text('Log in'),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          }
        });
  }
}
