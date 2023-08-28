// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const mainColor = Color(0XFFf26322);
const kTextLightColor = Color.fromARGB(255, 15, 15, 15);
const kDefaultPaddin = 20.0;
const kPrimarycolor = Color(0xFFec3237);

Future<http.Response> newMethod(String fullUrl) =>
      http.get(Uri.parse(fullUrl), headers: _setHeaders());

  _setHeaders() => {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json ',
      };