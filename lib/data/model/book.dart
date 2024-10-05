import 'dart:convert';

Book bookModelFromJson(String str) => Book.fromJson(json.decode(str));

class Book {
  String? id;
  String? name;
  String? thumbnail;
  List<String>? genres;
  int? viewCount;
  String? author;
  String? status;
  List<String>? chapters;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Book({
    this.id,
    this.name,
    this.thumbnail,
    this.genres,
    this.viewCount,
    this.author,
    this.status,
    this.chapters,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool isFirstChapter(String chapterId) {
    if (chapters == null) return false;
    return chapters?.first == chapterId;
  }

  bool isLastChapter(String chapterId) {
    if (chapters == null) return false;
    return chapters?.last == chapterId;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      genres: List<String>.from(json['genres'] ?? []),
      viewCount: json['viewCount'] ?? 0,
      author: json['author'],
      status: json['status'],
      chapters: List<String>.from(json['chapters'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'thumbnail': thumbnail,
      'genres': genres,
      'viewCount': viewCount,
      'author': author,
      'status': status,
      'chapters': chapters,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
