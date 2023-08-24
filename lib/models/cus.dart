// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<List<Customer>> customerFromJson(String str) => List<List<Customer>>.from(json.decode(str).map((x) => List<Customer>.from(x.map((x) => Customer.fromJson(x)))));

String customerToJson(List<List<Customer>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Customer {
    int id;
    String name;
    String gender;
    DateTime birth;
    String study;
    String worktype;
    String workplace;
    String phone;
    List<Realestate> realestates;

    Customer({
        required this.id,
        required this.name,
        required this.gender,
        required this.birth,
        required this.study,
        required this.worktype,
        required this.workplace,
        required this.phone,
        required this.realestates,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        birth: DateTime.parse(json["birth"]),
        study: json["study"],
        worktype: json["worktype"],
        workplace: json["workplace"],
        phone: json["phone"],
        realestates: List<Realestate>.from(json["realestates"].map((x) => Realestate.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "birth": "${birth.year.toString().padLeft(4, '0')}-${birth.month.toString().padLeft(2, '0')}-${birth.day.toString().padLeft(2, '0')}",
        "study": study,
        "worktype": worktype,
        "workplace": workplace,
        "phone": phone,
        "realestates": List<dynamic>.from(realestates.map((x) => x.toJson())),
    };
}

class Realestate {
    int id;
    int pid;
    String compound;
    String address;
    String realestateownername;
    String relation;
    String housingstatus;

    Realestate({
        required this.id,
        required this.pid,
        required this.compound,
        required this.address,
        required this.realestateownername,
        required this.relation,
        required this.housingstatus,
    });

    factory Realestate.fromJson(Map<String, dynamic> json) => Realestate(
        id: json["id"],
        pid: json["pid"],
        compound: json["compound"],
        address: json["address"],
        realestateownername: json["realestateownername"],
        relation: json["relation"],
        housingstatus: json["housingstatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pid": pid,
        "compound": compound,
        "address": address,
        "realestateownername": realestateownername,
        "relation": relation,
        "housingstatus": housingstatus,
    };
}
