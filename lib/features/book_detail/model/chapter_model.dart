import 'dart:convert';

ChapterModel chapterModelFromJson(String str) =>
    ChapterModel.fromJson(json.decode(str));

class ChapterModel {
  final String id;
  final String title;
  final List<String> pages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChapterModel({
    required this.id,
    required this.title,
    required this.pages,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a ChapterModel from a JSON map
  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      pages: List<String>.from(json['pages']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert a ChapterModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'pages': pages,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
