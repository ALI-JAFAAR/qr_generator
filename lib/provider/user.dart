// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../constants.dart';
import '../models/cus.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login.dart';
import '../screens/login/otp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class UserProvider extends ChangeNotifier {
  Api api = Api();
  var userdata;
  bool login = false;
  late SnackBar snackBar;
  String verificationId = "";
  String sms = "";
  final auth = FirebaseAuth.instance;
  auth_user(context, text) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: text));
      if (credential.user != null) {
        localStorage.setInt('id', userdata.id);
        localStorage.setString('name', userdata.name);
        localStorage.setString('phone', userdata.phone);
        localStorage.setString('birth', userdata.birth.toString());
        localStorage.setString('gender', userdata.gender);
        localStorage.setString('study', userdata.study);
        localStorage.setString('worktype', userdata.worktype);
        localStorage.setString('workplace', userdata.workplace);
        localStorage.setString('phone', userdata.phone);
        localStorage.setString('qrstatus', userdata.qrstatus);
        localStorage.setString('fcmtoken', userdata.fcmtoken);
        localStorage.setInt('real_id', userdata.realestates[0].id);
        localStorage.setInt('pid', userdata.realestates[0].pid);
        localStorage.setString('compound', userdata.realestates[0].compound);
        localStorage.setString('address', userdata.realestates[0].address);
        localStorage.setString(
            'realestateownername', userdata.realestates[0].realestateownername);
        localStorage.setString('relation', userdata.realestates[0].relation);
        localStorage.setString(
            'housingstatus', userdata.realestates[0].housingstatus);
        login = true;
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } catch (error) {
      snackbar(context, "رمز التحقق خاطئ");
    }
  }

  userlogin(BuildContext context, phone) async {
    final x = await newMethod(
        'https://www.almawadda-software.com/cims/api/CheckServices.php?Phone=$phone');
    if (x.body == "Error") {
      snackbar(context, "رقم الهاتف غير موجود يرجى مراجعة الادارة المحلية");
      return;
    } else if (x.body == "true") {
      snackbar(context, "رقم الهاتف موجود لم يدفع خدمات");
      return;
    }  else {
      final response = await newMethod('https://almawadda-software.com/cims/api/GetPersonalData.php?Phone=$phone');
      if (response.statusCode == 200) {





        List<List<Customer>> logindata = customerFromJson(response.body);
        userdata = logindata[0][0];
        notifyListeners();
        print("sdjcbisdbflkjvbsiudfbvbisidfbvif = ${userdata.realestates[0].housingstatus}");
        if(userdata.realestates[0].housingstatus != "ساكن"){
          snackbar(context, "الخدمة متوفرة للساكنين فقط");
          return;
        }
        var phoneNumber = phone;
        phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
        phoneNumber = phoneNumber.replaceFirst(RegExp(r'^0+'), '');
        phoneNumber = phoneNumber.replaceFirst('+964', '');
        phoneNumber = '+964$phoneNumber';

        sendotp(context, phoneNumber, response);
      }
    }
  }

  check_login(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (login == true) {
      var id = OneSignal.User.pushSubscription.id;
      fcmtoken(context, id);
    } else {
      if (localStorage.getInt('id') != null) {
        Realestate resl = Realestate(
          id: localStorage.getInt('real_id')!,
          pid: localStorage.getInt('pid')!,
          address: localStorage.getString('address')!,
          compound: localStorage.getString('compound')!,
          housingstatus: localStorage.getString('housingstatus')!,
          realestateownername: localStorage.getString('realestateownername')!,
          relation: localStorage.getString('relation')!,
        );
        Customer da = Customer(
          name: localStorage.getString('name')!,
          id: localStorage.getInt('id')!,
          phone: localStorage.getString('phone')!,
          qrstatus: localStorage.getString('qrstatus')!,
          fcmtoken: localStorage.getString('fcmtoken')!,
          birth: DateTime.parse(localStorage.getString('birth')!),
          gender: localStorage.getString('gender')!,
          realestates: [
            resl,
          ],
          study: localStorage.getString('study')!,
          workplace: localStorage.getString('workplace')!,
          worktype: localStorage.getString('worktype')!,
        );
        userdata = da;
        login = true;
        var id = OneSignal.User.pushSubscription.id;
        fcmtoken(context, id);
        if (kDebugMode) {
          print("user login id = ${userdata.id}");
          var token = OneSignal.User.pushSubscription.id;
          print("token token = $token");
          fcmtoken(context, token);
        }
        notifyListeners();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      }
    }
  }

  logout(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('id');
    localStorage.remove('name');
    localStorage.remove('phone');
    localStorage.remove('birth');
    localStorage.remove('gender');
    localStorage.remove('study');
    localStorage.remove('workplace');
    localStorage.remove('worktype');
    localStorage.remove('real_id');
    localStorage.remove('pid');
    localStorage.remove('address');
    localStorage.remove('compound');
    localStorage.remove('housingstatus');
    localStorage.remove('realestateownername');
    localStorage.remove('relation');
    login = false;
    snackbar(context, "تم تسجيل الخروج");
    notifyListeners();
  }

  update(
      BuildContext context, String name, String password, String phone) async {
    var data = {
      "name": name,
      "password": password,
      "phone": phone,
    };
    final response = await api.postData(data, 'cus-update/${userdata.id}');
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      var logindata = customerFromJson(response.body);

      if (datas["success"] == false) {
        snackbar(context, "حدث خطا ما");
      } else {
        userdata = logindata;
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setInt('id', userdata.id);
        localStorage.setString('name', userdata.name);
        localStorage.setString('phone', userdata.phone);
        snackbar(context, "تم تحديث البيانات بنجاح");
        login = true;
        notifyListeners();
        Navigator.pop(context);
      }
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  del_account(context, id) async {
    final response = await api.getData('del-cus/$id');
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);

      if (datas["success"] == true) {
        snackbar(context, "تم حذف الحساب ");
        logout(context);
        notifyListeners();
      } else {
        if (kDebugMode) {
          print("error delet account");
        }
      }
    }
  }

  fcmtoken(context, token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var phone = localStorage.getString('phone');

    if (phone != null) {
      if (token != null) {
        localStorage.setString('fcmtoken', token);
        final x = await newMethod(
            'https://almawadda-software.com/cims/api/UpdateFCMToken.php?Phone=$phone&FCMToken=$token');
        if (x.body != "Done") {
          return;
        }
      } else {
        var tokens = OneSignal.User.pushSubscription.id ?? "";
        localStorage.setString('fcmtoken', tokens);
        final x = await newMethod(
            'https://almawadda-software.com/cims/api/UpdateFCMToken.php?Phone=$phone&FCMToken=$tokens');
        if (x.body != "Done") {
          return;
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
      },
    );
  }

  void set_verfy(v) {
    verificationId = v;
    notifyListeners();
  }

  sendotp(context, phoneNumber, response) async {
    print("otp init");
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        set_verfy(verificationId);
        
        var id = OneSignal.User.pushSubscription.id;
        fcmtoken(context, id);
        print("otp sent");
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPScreen(),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  settoken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('fcmtoken');
    print("token token = $token");
    if (token != null) {
      localStorage.setString('fcmtoken', token);
      print("token token = $token");
    } else {
      var id = OneSignal.User.pushSubscription.id;
      if (id != null) {
        localStorage.setString('fcmtoken', id);
        print("token token = $id");
      }
    }
  }
}
