// To parse this JSON data, do
//
//     final slider = sliderFromJson(jsonString);

import 'dart:convert';

Slider sliderFromJson(String str) => Slider.fromJson(json.decode(str));

String sliderToJson(Slider data) => json.encode(data.toJson());

class Slider {
    bool success;
    List<Datum> data;

    Slider({
        required this.success,
        required this.data,
    });

    factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id,type;
    String img;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.type,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        img: json["img"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
