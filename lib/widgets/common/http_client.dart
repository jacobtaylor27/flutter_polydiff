import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_polydiff/constants/http_routes.dart';

class HttpClient {
  // var client = http.Client();

  Future<http.Response> get(String api) async {
    var url = Uri.parse('$API_ENDPOINT$api');
    return await http.get(url);
  }

  Future<http.Response> post(String api, Map<String, dynamic> data) async {
    var url = Uri.parse('$API_ENDPOINT$api');
    return await http.post(url, body: json.encode(data), headers: {'Content-Type': 'application/json'});
  }
  
  Future<http.Response> put(String api, Map<String, dynamic> data) async {
    var url = Uri.parse('$API_ENDPOINT$api');
    return await http.put(url, body: json.encode(data), headers: {'Content-Type': 'application/json'});
  }
  
}