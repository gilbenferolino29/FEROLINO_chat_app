import 'package:chat_app/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app/src/global/constants.dart';
import 'package:chat_app/src/global/styles.dart';
import 'package:chat_app/src/screens/authentication/auth_screen.dart';
import 'package:chat_app/src/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../service_locators.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = 'register-screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCon = TextEditingController(),
      _passCon = TextEditingController(),
      _pass2Con = TextEditingController(),
      _usernameCon = TextEditingController();
  final AuthController _authController = locator<AuthController>();
  final NavigationService nav = locator<NavigationService>();

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    _pass2Con.dispose();
    _usernameCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
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
                      SizedBox(width: sizeH * 5),
                      GestureDetector(
                        onTap: () {
                          nav.pop();
                        },
                        child: const Icon(Icons.arrow_back_ios, size: 20),
                      ),
                      SizedBox(width: sizeH * 32),
                      Text(
                        'Sign up',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w700),
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
                  Text('Create Your Account',
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(27, 59, 154, 1))),
                  Text('Please enter info to create account',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
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
                                hintText: 'Email', focusColor: kPrimaryColor),
                            controller: _emailCon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: sizeV * 2),
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
                          SizedBox(height: sizeV * 2),
                          TextFormField(
                            style: kDesc,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                            ),
                            controller: _pass2Con,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (_passCon.text != _pass2Con.text) {
                                return 'Passwords do not match!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: sizeV * 2),
                          TextFormField(
                            style: kDesc,
                            decoration: const InputDecoration(
                              hintText: 'Enter username',
                            ),
                            controller: _usernameCon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
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
                    onPressed: (_formKey.currentState?.validate() ?? false)
                        ? () {
                            _authController.register(
                                email: _emailCon.text.trim(),
                                password: _passCon.text.trim(),
                                username: _usernameCon.text.trim());
                          }
                        : null,
                    child: Text('Register', style: kTitle),
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
                      'Already Have an Account?',
                      style: kDesc,
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        nav.pushNamed(AuthScreen.route);
                      },
                      child: Text(
                        'LOG IN',
                        style: kDesc2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
