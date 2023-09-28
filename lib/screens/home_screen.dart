import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polydiff/classes/auth.dart';
import 'package:flutter_polydiff/classes/communication_socket.dart';
import 'package:flutter_polydiff/classes/user_repository.dart';
import 'package:flutter_polydiff/enum/socket_events.dart';
import 'package:flutter_polydiff/interfaces/message.dart';
import 'package:flutter_polydiff/providers/chat_provider.dart';
import 'package:flutter_polydiff/providers/user_provider.dart';
import 'package:flutter_polydiff/screens/chat_screen.dart';
import 'package:flutter_polydiff/screens/signin_screen.dart';
import 'package:flutter_polydiff/widgets/common/reusable_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  onClickChat(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
  }

  @override void initState() {
    super.initState();
    CommunicationSocket.init();
     CommunicationSocket.on(SocketEvents.message, (data) {
        Provider.of<ChatListProvider>(context, listen: false)
        .addMessage(Message(
            message: data['body'].toString(), 
            sender: data['sender'].toString(), 
            time: data['timeStamp'].toString(),
          ));
    });
  }

  Future signOut() async {
    try{
      CommunicationSocket.off(SocketEvents.message);
      CommunicationSocket.disconnect();
      UserRepository().signOutUser(Provider.of<UserProvider>(context, listen: false).user!.uid);
      Provider.of<ChatListProvider>(context, listen: false).clearList();
      Auth().signOut().then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()))
      });
    } on FirebaseAuthException catch (e) {
        Logger().e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Consumer<UserProvider>(
      builder: (context, userProviderModel, child) =>
      Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,0, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80),
                Text(
                  'Welcome ${userProviderModel.user?.username}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),  
                const SizedBox(height: 40,),
                SizedBox(
                  width: 300,
                  child: basicButton(context, "Chat", () {onClickChat();})
              ),
              const SizedBox(height: 40,),
                SizedBox(
                  width: 300,
                  child: basicButton(context, "Sign Out", () {signOut(); })
              ),
              ],
            )
          ) 
        ),
      ),
    );
  }
}