import 'dart:convert';
import 'dart:io';

import 'package:fable_cosmic_read_app_fe/core/constant/api_config.dart';
import 'package:fable_cosmic_read_app_fe/data/model/user.dart';

class UserRepo {
  Future<User> authenticate(
      {required String email, required String password}) async {
    var client = HttpClient();
    try {
      var request = await client.postUrl(Uri.parse(ApiConfig.login()));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.add(
          utf8.encode(json.encode({"email": email, "password": password})));

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 &&
          jsonResponse['message'] == 'Login successful') {
        return User.fromJson(jsonResponse['data']);
      } else {
        throw Exception(jsonResponse['message'] ?? 'Authentication failed');
      }
    } catch (e) {
      throw Exception('Error during authentication: $e');
    } finally {
      client.close();
    }
  }

  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    var client = HttpClient();
    try {
      var request = await client.postUrl(Uri.parse(ApiConfig.register()));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.add(utf8.encode(
          json.encode({"email": email, "password": password, "name": name})));

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var jsonResponse = json.decode(responseBody);

      if (response.statusCode == 201 &&
          jsonResponse['message'] == 'Register successful') {
        return User.fromJson(jsonResponse['data']);
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to register');
      }
    } catch (e) {
      throw Exception("User already exist");
    } finally {
      client.close();
    }
  }

  Future<User> getUserById({required String id, required String token}) async {
    var client = HttpClient();
    try {
      var request = await client.getUrl(Uri.parse(ApiConfig.getUserById(id)));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.headers.set(
          HttpHeaders.authorizationHeader, "Bearer $token"); // Set Bearer token

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200) {
        return User.fromJson(jsonResponse['data']);
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to get user');
      }
    } catch (e) {
      throw Exception('Error during get user by id: $e');
    } finally {
      client.close();
    }
  }
}
