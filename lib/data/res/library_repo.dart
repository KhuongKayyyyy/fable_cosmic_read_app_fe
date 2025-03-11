import 'dart:convert';
import 'dart:io';

import 'package:fable_cosmic_read_app_fe/core/constant/api_config.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/library.dart';

class LibraryRepo {
  Future<Library> getLibraryByUserId(
      {required String userId, required String token}) async {
    try {
      var client = HttpClient();
      var request =
          await client.getUrl(Uri.parse(ApiConfig.getLibraryByUserId(userId)));
      request.headers.set(
          HttpHeaders.authorizationHeader, "Bearer $token"); // Set Bearer token
      var response = await request.close();

      if (response.statusCode == 200) {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonData = jsonDecode(responseBody);
        if (jsonData['data'] is List) {
          // Handle list instead of a single map
          var books =
              (jsonData['data'] as List).map((e) => Book.fromJson(e)).toList();
          var library = Library(userId: userId, books: books);

          return library;
        } else {
          throw Exception("Unexpected data format: Expected List<dynamic>");
        }
      } else {
        throw Exception(
            "Failed to fetch library. Status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkIfBookIsInLibrary(
      {required String userId,
      required String bookId,
      required String token}) async {
    try {
      var client = HttpClient();
      var request = await client
          .getUrl(Uri.parse(ApiConfig.checkIfBookIsInLibrary(userId, bookId)));
      request.headers.set(
          HttpHeaders.authorizationHeader, "Bearer $token"); // Set Bearer token
      var response = await request.close();

      if (response.statusCode == 200) {
        var responseBody = await response.transform(utf8.decoder).join();
        var jsonData = jsonDecode(responseBody);
        return jsonData['data'] as bool;
      } else {
        throw Exception(
            "Failed to check if book is in library. Status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addBookToLibrary(
      {required String userId,
      required String bookId,
      required String token}) async {
    try {
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(ApiConfig.addBookToLibrary(userId)));
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({'bookId': bookId}));
      var response = await request.close();

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            "Failed to add book to library. Status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeBookFromLibrary(
      {required String userId,
      required String bookId,
      required String token}) async {
    try {
      var client = HttpClient();
      var request = await client.deleteUrl(
          Uri.parse(ApiConfig.removeBookFromLibrary(userId, bookId)));
      request.headers.set(
          HttpHeaders.authorizationHeader, "Bearer $token"); // Set Bearer token
      var response = await request.close();

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            "Failed to remove book from library. Status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> clearLibrary(
      {required String userId, required String token}) async {
    try {
      var client = HttpClient();
      var request =
          await client.deleteUrl(Uri.parse(ApiConfig.clearLibrary(userId)));
      request.headers.set(HttpHeaders.authorizationHeader, "Bearer $token");
      var response = await request.close();

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            "Failed to clear library. Status code: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
