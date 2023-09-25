// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static String verfy = "";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phone = TextEditingController();
  final pass = TextEditingController();

  bool xx = true;
  bool disable = false;
  late Color color;
  @override
  void initState() {
    super.initState();
    color = Color(0xff008e9b);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var user = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff008e9b),
        ),
        body: SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 90),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              Image.asset(
                                'assets/images/logo.png',
                                width: 200,
                                height: 140,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "رقم الهاتف",
                              style: GoogleFonts.cairo(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color.fromARGB(255, 222, 222, 224),
                                focusColor: Color(0XFFfff1f1),
                                filled: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextButton(
                        onPressed: () async {
                          // Define a regular expression for the phone number pattern
                          RegExp regex = RegExp(r'^07[578]\d{8}$');

                          // Use the RegExp `hasMatch` method to check if the input matches the pattern
                          if (regex.hasMatch(phone.text)) {
                            disable == false
                                ? user.userlogin(context, phone.text)
                                : "";
                            setState(() {
                              color = Color(0XFFf47c27);
                              disable = true;
                            });
                          }else{
                            user.snackbar(context,"رجاء قم بادخال رقم هاتف صحيح");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => color,
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
