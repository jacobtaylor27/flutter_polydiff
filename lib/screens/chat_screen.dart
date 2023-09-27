import 'package:flutter/material.dart';
import 'package:flutter_polydiff/classes/communication_socket.dart';
import 'package:flutter_polydiff/enum/socket_events.dart';
import 'package:flutter_polydiff/interfaces/message.dart';
import 'package:flutter_polydiff/providers/chat_provider.dart';
import 'package:flutter_polydiff/widgets/chat/messages_widget.dart';
import 'package:provider/provider.dart';

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
  }

  sendMessage(String msg){
    CommunicationSocket.send(SocketEvents.message, {"body": msg, "sender": "lau"}, );
    Provider.of<ChatListProvider>(context, listen: false).addMessage(Message(message: msg, sender: "Laurie", isSelf: true));
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
     body: Consumer<ChatListProvider>(
      builder: (context, chatProviderModel, child) => SizedBox(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatProviderModel.messages.length, 
                itemBuilder: (context, index) {
                  if(chatProviderModel.messages[index].isSelf){
                    return OwnMessageWidget(message: chatProviderModel.messages[index].message, sender: chatProviderModel.messages[index].sender);
                  } else {  
                    return OtherMessageWidget(message: chatProviderModel.messages[index].message, sender: chatProviderModel.messages[index].sender);
                  }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
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
                    ),
                  ),
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
              ),
            ),
          ],
        ),
      ),
    ),
    );  
  }
}
