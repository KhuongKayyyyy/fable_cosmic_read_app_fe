import 'package:fable_cosmic_read_app_fe/data/model/book.dart';

class Library {
  String userId;
  List<Book> books;

  Library({
    required this.userId,
    required this.books,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      userId: json['userId'] ?? '',
      books: (json['data'] as List).map((e) => Book.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'books': books.map((book) => book.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Library{userId: $userId, books: $books}';
  }
}
