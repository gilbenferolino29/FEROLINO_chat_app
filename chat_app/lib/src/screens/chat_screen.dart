// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:chat_app/src/controllers/auth_controller.dart';
import 'package:chat_app/src/controllers/chat_controller.dart';
import 'package:chat_app/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app/src/global/constants.dart';
import 'package:chat_app/src/global/styles.dart';
import 'package:chat_app/src/model/chat_message_model.dart';
import 'package:chat_app/src/model/chat_user_model.dart';
import 'package:chat_app/src/screens/onboarding/home_screen.dart';
import 'package:chat_app/src/service_locators.dart';
import 'package:chat_app/src/size_configs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  static const String route = 'chat-screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthController _auth = locator<AuthController>();
  final ChatController _chatController = ChatController();
  final NavigationService nav = locator<NavigationService>();

  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFN = FocusNode();
  final ScrollController _scrollController = ScrollController();
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
    //_chatController.addListener(scrollToBottom);
    super.initState();
  }

  @override
  void dispose() {
    //_chatController.removeListener(scrollToBottom);
    _messageFN.dispose();
    _messageController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 250));
    print('scrolling to bottom');
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
              height: sizeV * 100, width: sizeH * 100, color: kSecondaryColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    nav.pushReplacementNamed(HomeScreen.route);
                  },
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Global Chat',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              padding: EdgeInsets.only(top: 50, bottom: 80),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                  )),
              height: sizeV * 84,
              width: sizeH * 100,
              child: AnimatedBuilder(
                  animation: _chatController,
                  builder: (context, Widget? w) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          for (ChatMessage chat in _chatController.chats)
                            ChatCard(chat: chat)
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 20),
              height: sizeV * 10,
              width: sizeH * 100,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onFieldSubmitted: (String text) {
                        send();
                      },
                      cursorColor: kSecondaryColor,
                      focusNode: _messageFN,
                      controller: _messageController,
                      decoration: InputDecoration(
                        fillColor: kSecondaryColor3,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: kSecondaryColor, size: 30),
                    onPressed: send,
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  send() {
    _messageFN.unfocus();
    if (_messageController.text.isNotEmpty) {
      _chatController.sendMessage(message: _messageController.text.trim());
      _messageController.text = '';
    }
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatMessage chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: chat.sentBy == FirebaseAuth.instance.currentUser?.uid
          ? const EdgeInsets.fromLTRB(50, 10, 10, 10)
          : const EdgeInsets.fromLTRB(10, 10, 50, 10),
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: chat.sentBy == FirebaseAuth.instance.currentUser?.uid
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15))
            : BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
        color: chat.sentBy == FirebaseAuth.instance.currentUser?.uid
            ? kSecondaryColor
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              color: chat.sentBy == FirebaseAuth.instance.currentUser?.uid
                  ? kSecondaryColor
                  : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<ChatUser>(
                      future: ChatUser.fromUid(uid: chat.sentBy),
                      builder: (context, AsyncSnapshot<ChatUser> snap) {
                        if (snap.hasData) {
                          return Row(
                            mainAxisAlignment: chat.sentBy ==
                                    FirebaseAuth.instance.currentUser?.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Text(
                                  chat.sentBy ==
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? 'You sent:'
                                      : '${snap.data?.username} sent',
                                  style: chat.sentBy ==
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? messageOwn
                                      : messageOther),
                            ],
                          );
                        }
                        return const Text('User');
                      }),
                  Row(
                    mainAxisAlignment:
                        chat.sentBy == FirebaseAuth.instance.currentUser?.uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Text(chat.message,
                          style: chat.sentBy ==
                                  FirebaseAuth.instance.currentUser?.uid
                              ? messageOwn
                              : messageOther),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          DateFormat.yMMMMd('en_US')
                              .add_jm()
                              .format(chat.ts.toDate())
                              .toString(),
                          style: chat.sentBy ==
                                  FirebaseAuth.instance.currentUser?.uid
                              ? messageOwn
                              : messageOther)
                    ],
                  )
                  // Text(
                  //     'Message seen by ${chat.seenBy}')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
