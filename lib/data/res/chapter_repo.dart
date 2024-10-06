import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:fable_cosmic_read_app_fe/core/constant/api_config.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';

class ChapterRepo {
  static Future<Chapter?> fetchChapter(String chapterId) async {
    var client = HttpClient();
    Chapter? chapter;

    try {
      var request =
          await client.getUrl(Uri.parse(ApiConfig.getChapterById(chapterId)));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        log(decodedJson.toString());

        // Check if 'data' key exists and is a Map
        if (decodedJson is Map<String, dynamic> &&
            decodedJson.containsKey('data')) {
          var chapterData = decodedJson['data']; // Extract the 'data' field

          // Ensure chapterData is a Map
          if (chapterData is Map<String, dynamic>) {
            chapter =
                Chapter.fromJson(chapterData); // Pass chapterData to fromJson
            log('Fetched chapter: ${chapter.toString()}');
          }
        }
      }
      return chapter;
    } catch (e) {
      log("Chapter Repo: ${e.toString()}");
      return null;
    } finally {
      client.close();
    }
  }
}
