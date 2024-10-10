import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fable_cosmic_read_app_fe/core/constant/api_config.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';

class GenreRepo {
  static Future<List<Genre>> fetchGenres(
      int? page, int? size, String? searchString) async {
    var client = HttpClient();
    List<Genre> genres = [];

    try {
      var request = await client
          .getUrl(Uri.parse(ApiConfig.getAllGenres(page, size, searchString)));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List) {
          List result = decodedJson['data'];

          for (var i = 0; i < result.length; i++) {
            Genre genre = Genre.fromJson(result[i] as Map<String, dynamic>);
            genres.add(genre);
          }

          log('Fetched genres: ${genres.toString()}');
        }
      }
      return genres;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
