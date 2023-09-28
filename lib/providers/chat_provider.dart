import 'package:flutter/material.dart';
import 'package:flutter_polydiff/interfaces/message.dart';

class ChatListProvider extends ChangeNotifier {
  List<Message> messages = [];

  void addMessage(Message message) {
    messages.add(message);
    notifyListeners();
  }

  void clearList(){
    messages.clear();
    notifyListeners();
  }
}