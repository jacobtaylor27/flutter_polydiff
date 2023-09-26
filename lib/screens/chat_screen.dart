import 'package:flutter/material.dart';
import 'package:flutter_polydiff/classes/communication_socket.dart';
import 'package:flutter_polydiff/enum/socket_events.dart';
import 'package:flutter_polydiff/interfaces/message.dart';
import 'package:flutter_polydiff/screens/home_screen.dart';
import 'package:flutter_polydiff/widgets/chat/messages_widget.dart';
import 'package:logger/logger.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List <Message>messages = [];
  final ScrollController scrollController = ScrollController();
  TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    CommunicationSocket.on(SocketEvents.message, (data) {
      Logger().i(data);
      setState(() {
        messages.add(Message(message: (data["body"]).toString(), sender: data["sender"].toString()));
      });
        scrollController.jumpTo(scrollController.position.maxScrollExtent + 100);
        // scrollController.jumpTo(messages.length * 100.0);


    });
  }

  @override
  void dispose() {
    super.dispose();
    CommunicationSocket.off(SocketEvents.message);
  }

  onClickHome(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  sendMessage(String msg){
    CommunicationSocket.send(SocketEvents.message, {"body": msg, "sender": "lau"}, );
    messages.add(Message(message: msg, sender: "Laurie", isSelf: true));
    setState(() {
      messages;
    });
    messageTextController.clear();
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 100);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat"),
      ),
     body:
      Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length, 
            itemBuilder: (context, index) {
              if(messages[index].isSelf){
                return OwnMessageWidget(message: messages[index].message, sender: messages[index].sender);
              } else {  
                return OtherMessageWidget(message: messages[index].message, sender: messages[index].sender);
              }
            }
          ),),

        Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child:
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: messageTextController,
                  decoration: const InputDecoration(
                    hintText: "Type your message here",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                    ),
                  ),
                ),),
              IconButton(
                onPressed: (){
                  String msg = messageTextController.text;
                  if(msg.isNotEmpty){
                    sendMessage(msg);
                  }
                }, 
                icon: const Icon(Icons.send,),
                color: Colors.blue,
                ),
            ],
          )
        ),
        // Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
      ],
      ),);  
  }
}
