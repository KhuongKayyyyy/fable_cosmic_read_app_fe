import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fable_cosmic_read_app_fe/core/constant/api_config.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';

class BookRepo {
  static Future<List<Book>> fetchBooks() async {
    var client = HttpClient();
    List<Book> books = [];

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
            Book book = Book.fromJson(result[i] as Map<String, dynamic>);
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

  static Future<List<Chapter>> fetchChapter(String bookId) async {
    var client = HttpClient();
    List<Chapter> chapters = [];
    try {
      var request =
          await client.getUrl(Uri.parse(ApiConfig.getBookChapters(bookId)));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List) {
          List result = decodedJson['data'];
          for (var i = 0; i < result.length; i++) {
            Chapter chapter =
                Chapter.fromJson(result.elementAt(i) as Map<String, dynamic>);
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

  static Future<List<Genre>> fetchGenre(String bookId) async {
    var client = HttpClient();
    List<Genre> genres = [];
    try {
      var request =
          await client.getUrl(Uri.parse(ApiConfig.getBookGenres(bookId)));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List) {
          List result = decodedJson['data'];
          for (var i = 0; i < result.length; i++) {
            Genre genre =
                Genre.fromJson(result.elementAt(i) as Map<String, dynamic>);
            genres.add(genre);
          }
          log('Fetched genres: ${genres.toString()}');
        }
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
    return genres;
  }

  static Future<Book?> fetchBook(String bookId) async {
    var client = HttpClient();
    Book? book;
    try {
      var request =
          await client.getUrl(Uri.parse(ApiConfig.getBookById(bookId)));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is Map<String, dynamic>) {
          var result = decodedJson['data'];
          book = Book.fromJson(result as Map<String, dynamic>);
          log('Fetched book: ${book.toString()}');
        }
      }
      return book;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
