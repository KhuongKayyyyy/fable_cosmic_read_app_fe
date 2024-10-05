import 'dart:convert';

Genre genreModelFromJson(String str) => Genre.fromJson(json.decode(str));

class Genre {
  final String id;
  final String name;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Constructor
  Genre({
    required this.id,
    required this.name,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['_id'],
      name: json['name'],
      version: json['__v'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      '__v': version,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
