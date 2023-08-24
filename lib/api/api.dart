// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class Api {

  // var api = 'https://almawadda-software.com/cims/api/GetPersonalData.php';
  var api = 'https://qr.al-mawadda.com/api/';

  postData(data, apiUrl) async {
    var fullUrl = api + apiUrl;
    // var file = await DefaultCacheManager().getSingleFile(fullUrl, headers: _setHeaders());
    // if (await file.exists()) {
    //   var res = await file.readAsString();
    //   print('response cached');
    //   return http.Response(res, 200);
    // }else{
        return await http.post(Uri.parse(fullUrl),body: jsonEncode(data), headers: _setHeaders());
    // }
  }

  getData(apiUrl) async {
  
    var fullUrl = api + apiUrl;
    
    var file = await DefaultCacheManager().getSingleFile(fullUrl, headers: _setHeaders());
  
    if (await file.exists()) {
      var res = await file.readAsString();
      print('response cached');
      return http.Response(res, 200);
  
    }else{
  
      return await newMethod(fullUrl);
  
    }
  
  }

  Future<http.Response> newMethod(String fullUrl) =>
      http.get(Uri.parse(fullUrl), headers: _setHeaders());

  _setHeaders() => {
        'Content-type': 'application/json; charset=utf-8', 
        'Accept': 'application/json ',
      };
}