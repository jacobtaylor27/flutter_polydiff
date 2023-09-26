import 'package:flutter/material.dart';
import 'package:flutter_polydiff/screens/home_screen.dart';
import 'package:flutter_polydiff/widgets/common/reusable_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  onClickHome(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              const Text(
               "Chat Screen"
              ),  
              const SizedBox(height: 40,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicButton(context, "Home", () {onClickHome();})
            ),
            ],
          )
        ) 
      ),);
  }
}