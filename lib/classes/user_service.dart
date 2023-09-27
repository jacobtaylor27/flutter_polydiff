import 'package:flutter_polydiff/constants/http_routes.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<http.Response> getUserById(String uid) async {
    return await http.get(Uri.parse('$API_ENDPOINT$USER_ENDPOINT/$uid'));
  }
}