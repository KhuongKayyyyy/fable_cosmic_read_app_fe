import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fable_cosmic_read_app_fe/utils/api_config.dart';
import 'package:fable_cosmic_read_app_fe/features/home/model/book_model.dart';

class BookRepo {
  static Future<List<BookModel>> fetchBooks() async {
    var client = HttpClient();
    List<BookModel> books = [];

    try {
      var request = await client.getUrl(Uri.parse(ApiConfig.getAllBook));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List) {
          List result = decodedJson['data'];

          for (var i = 0; i < result.length; i++) {
            BookModel book =
                BookModel.fromJson(result[i] as Map<String, dynamic>);
            books.add(book);
          }

          log('Fetched books: ${books.toString()}');
        }
      }
      return books;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
