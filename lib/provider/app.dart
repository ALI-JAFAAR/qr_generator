// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/cat.dart';
import '../screens/home/components/qr_generate.dart';

class AppProvider extends ChangeNotifier {
  Api api = Api();
  late SnackBar snackBar;

  int catAcount = 0;
  bool catAwaiting = true;
  var catA;
  qr_all() async {
    if (catAwaiting == false) {
    } else {
      catAwaiting = true;
      final response = await api.getData('cats');
      print(response.statusCode);
      if (response.statusCode == 200) {
        var datas = json.decode(response.body);
        if (datas["success"] == true) {
          var cat = categoryFromJson(response.body);
          print(
              "CATS fethed successfully and count of them = ${cat.data.length}");
          catAcount = cat.data.length;
          catAwaiting = false;
          catA = cat.data;
          notifyListeners();
        } else {
          print("error fitching  cats");
        }
      }
    }
  }

  send_order(visit, user, context) async {
    var qr_data = user.phone + generateRandomString();
    var data = {'visitor_name':visit,"data": qr_data, "user": user};
    print(data);
    final response = await api.postData(data, 'qr');
    if (response.statusCode == 200||response.statusCode == 201) {
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  GenerateQRCode(data: qr_data,),
          ),
        );
      
    } else {
      print(response.statusCode);
    }
  }

  void snackbar(context, String text) {
    snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String generateRandomString() {
    var length = 30;
    final random = Random();
    final List<int> charCodes = List.generate(
      length,
      (index) => random.nextInt(26) + 97, // Generates lowercase alphabets
    );

    return String.fromCharCodes(charCodes);
  }

  
}
