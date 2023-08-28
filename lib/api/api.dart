// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // var api = 'https://almawadda-software.com/cims/api/GetPersonalData.php';
  var api = 'https://qr.al-mawadda.com/api/';

  postData(data, apiUrl) async {
    var fullUrl = api + apiUrl;

    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = api + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json ',
      };
}
