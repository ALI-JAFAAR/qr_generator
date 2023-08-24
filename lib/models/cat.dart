// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    bool success;
    List<Cats> data;

    Category({
        required this.success,
        required this.data,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        success: json["success"],
        data: List<Cats>.from(json["data"].map((x) => Cats.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Cats {
    int id;
    String name;
    String img;
    DateTime createdAt;
    DateTime updatedAt;

    Cats({
        required this.id,
        required this.name,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Cats.fromJson(Map<String, dynamic> json) => Cats(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}