// ignore_for_file: must_be_immutable

import '/provider/user.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({Key? key}) : super(key: key);

  final name =  TextEditingController();
  final phone =  TextEditingController();
  final pass =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimarycolor,
          title: const Text(
            'تحديث المعلومات',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(kDefaultPaddin),
            child: Column(
              children: [
                const SizedBox(height: 50),

                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                            label: Text('الاسم'),
                            prefixIcon: Icon(LineAwesomeIcons.user)),
                      ),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(
                            label: Text('رقم الهاتف'),
                            prefixIcon: Icon(LineAwesomeIcons.phone)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text('كلمة المرور'),
                          prefixIcon: const Icon(Icons.fingerprint),
                          suffixIcon: IconButton(
                              icon: const Icon(LineAwesomeIcons.eye_slash),
                              onPressed: () {}),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // -- Form Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            user.update(context, name.text, pass.text, phone.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimarycolor,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text(
                            'حفظ البيانات',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
