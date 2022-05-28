// ignore_for_file: prefer_const_constructors

import 'package:chat_app/src/controllers/auth_controller.dart';

import 'package:chat_app/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app/src/global/constants.dart';
import 'package:chat_app/src/global/styles.dart';
import 'package:chat_app/src/model/chat_user_model.dart';
import 'package:chat_app/src/screens/chat_screen.dart';
import 'package:chat_app/src/size_configs.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service_locators.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _auth = locator<AuthController>();
  final NavigationService nav = locator<NavigationService>();
  ChatUser? user;

  @override
  void initState() {
    ChatUser.fromUid(uid: _auth.currentUser!.uid).then((value) {
      if (mounted) {
        setState(() {
          user = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _auth.logout();
        },
        backgroundColor: kSecondaryColor,
        child: const Icon(Icons.logout),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(user?.username ?? '...'),
        backgroundColor: kSecondaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                splashRadius: 25,
                icon: const Icon(Icons.search, size: 25)),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
              height: sizeV * 100, width: sizeH * 100, color: kSecondaryColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Messages',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: sizeV * 84,
              width: sizeH * 100,
              child: Column(
                children: [
                  Container(
                    height: sizeV * 10,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(5, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [Text('Circle goes here')],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      splashColor: kSecondaryColor2,
                      onTap: () {
                        nav.pushReplacementNamed(ChatScreen.route);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: sizeV * 10,
                        width: sizeH * 100,
                        decoration: BoxDecoration(
                          color: kSecondaryColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 20,
                              ),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kPrimaryColor3),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Global Chat', style: kChat),
                                ),
                                Container(
                                  width: sizeH * 60,
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'This is some message for text huhuuhuhu wtf is this shit asdasdasdasd',
                                    style: kChat2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
