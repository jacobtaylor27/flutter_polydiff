import 'package:flutter_polydiff/enum/socket_events.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

class CommunicationSocket{
  static Socket? socket;

  static void init() {
    try {
      Logger().i(socket);
      if (socket == null) {
        socket = io('http://localhost:3000', <String, dynamic>{
          'transports ': ['websocket'],
          'autoConnect': false,
        });
        socket?.connect();
        Logger().i(socket?.connected);
      }
    } catch (e) {
      Logger().e(e);
      // Handle URISyntaxException
    }
  }

  static Socket getSocket() {
    return socket!;
  }

  

  static void disconnect() {
    socket?.disconnect();
    socket = null;
  }

  static void on(SocketEvents event, Function(dynamic) callback) {
    socket?.on(event.name, callback);
  }

  static void send(SocketEvents event, [dynamic data]) {
    socket?.emit(event.name, data);
  }

  static void off(SocketEvents event) {
    socket?.off(event.name);
  }
}