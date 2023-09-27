class Message {
  Message({required this.message, required this.sender, this.time, this.isSelf = false,});
  String message;
  String sender;
  bool isSelf = false;
  String? time;
}