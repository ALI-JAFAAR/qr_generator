import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import '../../provider/user.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String text;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff008e9b),
        ),
        body: Container(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
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
              const SizedBox(
                height: 40,
              ),
              const Text(
                "اكتب رمز التحقق المرسل اليك ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20.0),
              Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    setState(() {
                      text = code;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color(0xff008e9b),
                    ),
                  ),
                  onPressed: () async {
                    user.auth_user(context, text);
                  },
                  child: const Text(
                    "التحقق",
                    style: TextStyle(fontSize: 18),
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
