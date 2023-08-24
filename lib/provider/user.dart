// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings, depend_on_referenced_packages

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../models/cus.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login.dart';
import '../screens/login/otp.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  Api api = Api();
  var userdata;
  bool login = false;
  late SnackBar snackBar;
  String verificationId = "";
  createaccount(
      BuildContext context, String name, String password, String phone) async {
    var data = {
      "name": name,
      "password": password,
      "phone": phone,
    };
    final response = await api.postData(data, 'cus-signup');
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      print(response.body);
      var logindata = customerFromJson(response.body);

      if (datas["success"] == false) {
        snackbar(context, "حدث خطا ما");
      } else {
        userdata = logindata;
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setInt('id', userdata.id);
        localStorage.setString('name', userdata.name);
        localStorage.setString('phone', userdata.phone);
        snackbar(context, "مرحبا بك ${userdata.name}");
        login = true;
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      print(response.body);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  auth_user(context, text) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: text);
    await auth.signInWithCredential(credential);
    print(auth.currentUser!.phoneNumber);
    auth.currentUser!.displayName;
    if (auth.currentUser != null) {
      snackbar(context, "مرحبا بك ${userdata.name}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  userlogin(BuildContext context, phone) async {
    final response = await newMethod(
        'https://almawadda-software.com/cims/api/GetPersonalData.php?phone=$phone');
    if (response.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var phoneNumber = phone;
      phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
      phoneNumber = phoneNumber.replaceFirst(RegExp(r'^0+'), '');
      phoneNumber = phoneNumber.replaceFirst('+964', '');
      phoneNumber = '+964' + phoneNumber;
      print(phoneNumber);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          set_verfy(verificationId);
          print("sdufncdcdionodcndoincdciod" + verificationId);
          print(response.body);
          List<List<Customer>> logindata = customerFromJson(response.body);
          userdata = logindata[0][0];
          print("user login data ${userdata.name}");
          localStorage.setInt('id', userdata.id);
          localStorage.setString('name', userdata.name);
          localStorage.setString('phone', userdata.phone);
          localStorage.setString('birth', userdata.birth.toString());
          localStorage.setString('gender', userdata.gender);
          localStorage.setString('study', userdata.study);
          localStorage.setString('worktype', userdata.worktype);
          localStorage.setString('workplace', userdata.workplace);
          localStorage.setString('phone', userdata.phone);
          localStorage.setInt('real_id', userdata.realestates[0].id);
          localStorage.setInt('pid', userdata.realestates[0].pid);
          localStorage.setString('compound', userdata.realestates[0].compound);
          localStorage.setString('address', userdata.realestates[0].address);
          localStorage.setString('realestateownername',
              userdata.realestates[0].realestateownername);
          localStorage.setString('relation', userdata.realestates[0].relation);
          localStorage.setString(
              'housingstatus', userdata.realestates[0].housingstatus);
          login = true;
          
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OTPScreen(),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      print(response.body);
    }
  }

  check_login(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (login == true) {
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
        snackbar(context, "مرحبا بك مجددا");
        print("user login id = ${userdata.id}");
        notifyListeners();
      } else {
        Navigator.push(
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
      print(response.body);
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
      print(response.body);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  del_account(context, id) async {
    final response = await api.getData('del-cus/$id');
    print(response.statusCode);
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);

      if (datas["success"] == true) {
        snackbar(context, "تم حذف الحساب ");
        logout(context);
        notifyListeners();
      } else {
        print("error delet account");
      }
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

  void set_verfy(v) {
    verificationId = v;
    notifyListeners();
  }

  Future<http.Response> newMethod(String fullUrl) =>
      http.get(Uri.parse(fullUrl), headers: _setHeaders());

  _setHeaders() => {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json ',
      };
}
