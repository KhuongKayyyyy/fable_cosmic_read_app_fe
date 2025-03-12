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

        if (decodedJson is Map<String, dynamic> &&
            decodedJson.containsKey('data')) {
          var chapterData = decodedJson['data'];

          if (chapterData is Map<String, dynamic>) {
            chapter = Chapter.fromJson(chapterData);
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
