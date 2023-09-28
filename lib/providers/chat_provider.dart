import 'package:flutter/material.dart';
import 'package:flutter_polydiff/interfaces/message.dart';
import 'package:logger/logger.dart';

class ChatListProvider extends ChangeNotifier {
  List<Message> messages = [];

  void addMessage(Message message) {
    Logger().i(message);
    messages.add(message);
    notifyListeners();
  }
}