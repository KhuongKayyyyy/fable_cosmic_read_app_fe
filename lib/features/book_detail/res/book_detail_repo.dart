import 'dart:convert';

import 'package:fable_cosmic_read_app_fe/features/book_detail/model/chapter_model.dart';
import 'package:fable_cosmic_read_app_fe/utils/api_config.dart';

import 'dart:developer';
import 'dart:io';

class BookDetailRepo {
  static Future<List<ChapterModel>> fetchChapter(String bookId) async {
    var client = HttpClient();
    List<ChapterModel> chapters = [];
    try {
      var request =
          await client.getUrl(Uri.parse(ApiConfig.getChapterOfBook(bookId)));
      log(ApiConfig.getChapterOfBook(bookId));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List) {
          List result = decodedJson['data'];
          for (var i = 0; i < result.length; i++) {
            ChapterModel chapter = ChapterModel.fromJson(
                result.elementAt(i) as Map<String, dynamic>);
            chapters.add(chapter);
          }
          log('Fetched chapters: ${chapters.toString()}');
        }
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
    return chapters;
  }
}
