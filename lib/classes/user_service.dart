import 'package:flutter_polydiff/constants/http_routes.dart';
import 'package:flutter_polydiff/models/user.dart';
import 'package:flutter_polydiff/widgets/common/http_client.dart';
import 'package:http/http.dart' as http;

class UserService {
  
  Future<http.Response> getUserById(String uid) async {
    return await HttpClient().get('$USER_ENDPOINT/$uid');
  }

  Future<http.Response> createUser(User user) async {
    return await HttpClient().post('$USER_ENDPOINT', user.toJson());
  }

  Future<http.Response> isUsernameAvailable(String username) async {
    return await HttpClient().get('$USER_ENDPOINT/check-username/$username');
  }

  Future<http.Response> signOutUser(String id) async {
    return await HttpClient().put('$USER_ENDPOINT/sign-out/$id', {});
  }

  Future<http.Response> signInUser(String id) async {
    return await HttpClient().put('$USER_ENDPOINT/sign-in/$id', {});
  }

  Future<http.Response> isUserSignedIn(String id) async {
    return await HttpClient().get('$USER_ENDPOINT/$id/status');
  }

}