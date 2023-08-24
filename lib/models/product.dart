// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
    bool success;
    List<Product> data;

    Products({
        required this.success,
        required this.data,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        success: json["success"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Product {
    int id;
    String name;
    String disc;
    int price;
    int qty;
    int catId;
    int old_price;
    int percent;
    String img;
    DateTime createdAt;
    DateTime updatedAt;
    Cat cat;

    Product({
        required this.id,
        required this.name,
        required this.disc,
        required this.price,
        required this.qty,
        required this.percent,
        required this.old_price,
        required this.catId,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
        required this.cat,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        disc: json["disc"],
        price: json["price"],
        qty: json["qty"],
        percent: json["percent"],
        old_price: json["old_price"],
        catId: json["cat_id"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        cat: Cat.fromJson(json["cat"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "disc": disc,
        "price": price,
        "old_price": old_price,
        "percent": percent,
        "qty": qty,
        "cat_id": catId,
        "img": img,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "cat": cat.toJson(),
    };
}

class Cat {
    int id;
    String name;
    String img;
    DateTime createdAt;
    DateTime updatedAt;

    Cat({
        required this.id,
        required this.name,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Cat.fromJson(Map<String, dynamic> json) => Cat(
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

