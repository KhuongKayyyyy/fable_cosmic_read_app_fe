class ApiConfig {
  static const String BASE_URL = 'http://127.0.0.1:3000/';

  static String getAllBooks(int page) {
    return '${BASE_URL}books?page=$page';
  }

  static String getBookById(String bookId) {
    return '${BASE_URL}books/$bookId';
  }

  static String getBookChapters(String bookId) {
    return '${BASE_URL}books/$bookId/chapters';
  }

  static String getBookGenres(String bookId) {
    return '${BASE_URL}books/$bookId/genres';
  }

  static String getChapterById(String chapterId) {
    return '${BASE_URL}chapters/$chapterId';
  }

  static String getBookByGenre(String genreId) {
    return '${BASE_URL}books/genre/$genreId';
  }

  static String getAllGenres(int? page, int? size, String? searchString) {
    String url = '${BASE_URL}genres';
    List<String> queryParams = [];

    if (page != null) {
      queryParams.add('page=$page');
    }
    if (size != null) {
      queryParams.add('size=$size');
    }
    if (searchString != null && searchString.isNotEmpty) {
      queryParams.add('search=$searchString');
    }

    if (queryParams.isNotEmpty) {
      url += '?${queryParams.join('&')}';
    }

    return url;
  }
}
