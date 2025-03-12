import 'dart:convert';
import 'dart:io';

import 'package:fable_cosmic_read_app_fe/core/constant/api_config.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';

class ContinueReadingRepo {
  Future<List<ContinueReadChapter>> getContinueReadingByUserId(
      {required String userId, required String token}) async {
    var client = HttpClient();
    try {
      var request = await client
          .getUrl(Uri.parse(ApiConfig.getContinueReadingByUserId(userId)));
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      var response = await request.close();

      if (response.statusCode == 200) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        // ✅ Handling list instead of a map
        List<dynamic> chaptersJson = decodedJson["data"];
        List<ContinueReadChapter> chapters = chaptersJson
            .map((item) => ContinueReadChapter.fromJson(item))
            .toList();
        return chapters;
      } else {
        throw Exception('Failed to load continue reading data');
      }
    } catch (e) {
      throw Exception('Failed to load continue reading data: $e');
    }
  }

  Future<void> saveContinueReading(
      {required String userId,
      required String token,
      required String chapterId,
      required String bookId}) async {
    var client = HttpClient();
    try {
      var request = await client
          .putUrl(Uri.parse(ApiConfig.addChapterToContinueReading(userId)));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      request.write(jsonEncode({"chapterId": chapterId, "bookId": bookId}));
      var response = await request.close();

      if (response.statusCode == 201) {
      } else {
        throw Exception('Failed to save continue reading data');
      }
    } catch (e) {
      throw Exception('Failed to save continue reading data: $e');
    }
  }

  Future<void> deleteBookFromContinueReading(
      {required String userId,
      required String token,
      required String chapterId}) async {
    var client = HttpClient();
    try {
      var request = await client.putUrl(
          Uri.parse(ApiConfig.removeChapterFromContinueReading(userId)));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      request.write(jsonEncode({"chapterId": chapterId}));
      var response = await request.close();

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete continue reading data');
      }
    } catch (e) {
      throw Exception('Failed to delete continue reading data: $e');
    }
  }

  Future<void> clearContinueReading(
      {required String userId, required String token}) async {
    var client = HttpClient();
    try {
      var request = await client
          .deleteUrl(Uri.parse(ApiConfig.clearContinueReading(userId)));
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      var response = await request.close();

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to clear continue reading data');
      }
    } catch (e) {
      throw Exception('Failed to clear continue reading data: $e');
    }
  }

  Future<ContinueReadChapter?> checkIfBookIsReading(
      {required String userId,
      required String token,
      required String bookId}) async {
    var client = HttpClient();
    try {
      var request = await client.postUrl(
          Uri.parse(ApiConfig.checkIfChapterIsInContinueReading(userId)));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      request.write(jsonEncode({"bookId": bookId}));
      var response = await request.close();

      if (response.statusCode == 200) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson["data"] != null) {
          var chapter = ContinueReadChapter.fromJson(decodedJson["data"]);
          print('Book is in continue reading: $chapter');
          return chapter;
        } else {
          print('Book is not in continue reading');
          return null;
        }
      } else {
        throw Exception('Failed to check if book is in continue reading');
      }
    } catch (e) {
      throw Exception('Failed to check if book is in continue reading: $e');
    }
  }
}
