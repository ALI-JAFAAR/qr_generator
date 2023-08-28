// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/app.dart';

import '../../../provider/user.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  String _inputValue = '';
  String _selectedOption = 'اختر صلة القرابة';

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var app = Provider.of<AppProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff008e9b),
              ),
              child: Text(""),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("معلومات التطبيق"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Add your navigation logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("تسجيل الخروج"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                user.logout(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'انشاء QR',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color(0xff008e9b),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 130,
                  width: 160,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          color: Colors.amber,
                          size: 25,
                        ),
                        Text(
                          ' الـ QR مخصص لزائر واحد فقط ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          color: Colors.amber,
                          size: 25,
                        ),
                        Text(
                          ' الـ QR  صالح لمدة 24 ساعة',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      // prefix: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'ادخل  اسم الزائر ',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _inputValue = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(4)),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        value: _selectedOption,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                        },
                        items: <String>[
                          'اختر صلة القرابة',
                          'صديق',
                          'اقارب',
                          'عمل'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    const Flexible(
                      child: Text(
                        'اتعهد بتحمل كافة المسؤليات في حال مخالفة الزائر للقوانين والضوابط الخاصة بالمجمع السكني',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => const Color(0xff008e9b),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isChecked) {
                          app.send_order(_inputValue, user.userdata, context);
                          print("Text Input: $_inputValue");
                          print("Checkbox Checked: $_isChecked");
                          print("Selected Option: $_selectedOption");
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "رجاء قم  بتحديد التعهد قبل  الانشاء",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ));
                        }
                      }
                    },
                    child: const Text(
                      'انشأ الـ QR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
