class ContinueReading {
  final String id;
  final String user;
  final List<ContinueReadChapter> chapters;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ContinueReading({
    required this.id,
    required this.user,
    required this.chapters,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ContinueReading.fromJson(Map<String, dynamic> json) {
    return ContinueReading(
      id: json["_id"],
      user: json["user"],
      chapters: (json["chapters"] as List)
          .map((item) => ContinueReadChapter.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user,
      "chapters": chapters.map((item) => item.toJson()).toList(),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }

  @override
  String toString() {
    return 'ContinueReading{id: $id, user: $user, chapters: $chapters, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }
}

class ContinueReadChapter {
  final String chapterId;
  final String bookId;
  final String chapterName;
  final String bookName;
  final String bookAuthor;
  final String bookImage;

  ContinueReadChapter({
    required this.chapterId,
    required this.bookId,
    required this.chapterName,
    required this.bookName,
    required this.bookAuthor,
    required this.bookImage,
  });

  factory ContinueReadChapter.fromJson(Map<String, dynamic> json) {
    return ContinueReadChapter(
      chapterId: json["chapterId"] ?? "Unknown",
      bookId: json["bookId"] ?? "Unknown",
      chapterName: json["chapterName"] ?? "Unknown",
      bookName: json["bookName"] ?? "Unknown",
      bookAuthor: json["bookAuthor"] ?? "Unknown",
      bookImage: json["bookImage"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "chapterId": chapterId,
      "bookId": bookId,
      "chapterName": chapterName,
      "bookName": bookName,
      "bookAuthor": bookAuthor,
      "bookImage": bookImage,
    };
  }

  factory ContinueReadChapter.empty() {
    return ContinueReadChapter(
      chapterId: "",
      bookId: "",
      chapterName: "",
      bookName: "",
      bookAuthor: "",
      bookImage: "",
    );
  }

  @override
  String toString() {
    return 'ContinueReadChapter{chapterId: $chapterId, chapterName: $chapterName, bookName: $bookName, bookAuthor: $bookAuthor, bookImage: $bookImage}';
  }
}
