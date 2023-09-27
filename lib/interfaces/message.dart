
class Message {
  String message;
  String sender;
  bool isSelf = false;
  String? time;
  Message({required this.message, required this.sender, this.time, this.isSelf = false,});
}