class ApiConfig {
  static const String BASE_URL = 'http://127.0.0.1:3000/';

  static const String getAllBook = BASE_URL + 'books';

  static String getChapterOfBook(String bookId) {
    return BASE_URL + 'books/' + bookId + '/chapters';
  }
}
