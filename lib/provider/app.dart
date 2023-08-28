// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';
import '../constants.dart';
import '../screens/home/components/qr_generate.dart';

class AppProvider extends ChangeNotifier {
  Api api = Api();
  late SnackBar snackBar;

  send_order(visit, user, context) async {
    var qr_data = user.phone + generateRandomString();
    var data = {'visitor_name': visit, "data": qr_data, "user": user};
    final response = await newMethod(
        'https://www.almawadda-software.com/cims/api/CheckServices.php?Phone=${user.phone}');
    if (response.statusCode == 200) {
      print(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var status = localStorage.getString('qrstatus')!;
      if(status == "غير فعال"){
        snackbar(context, ' تم ايقاف الحساب يرجى مراجعة قسم المعلوماتية ');
      }
      if (response.body == "true") {
        snackbar(context, 'لايمكن توليد الـQR المالك متلكئ عن دفع الخدمات');
      } else if (response.body == "true") {
      } else if (response.body == "Error") {
        snackbar(context, ' رقم الهاتف غير موجود يرجى مراجعة قسم المعلوماتية ');
      } else {
        final x = await api.postData(data, 'qr');
        if (x.statusCode == 200 || x.statusCode == 201) {
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenerateQRCode(
                data: qr_data,
              ),
            ),
          );
        } else {
          print(response.statusCode);
        }
      }
    }
  }

  void snackbar(context, String text) {
    showDialog(
        context: context,
        builder: (_) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text(
                'تحذير',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              content: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'اخفاء',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
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
