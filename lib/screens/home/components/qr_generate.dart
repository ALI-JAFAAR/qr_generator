// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/provider/user.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import 'dart:io';
import 'dart:typed_data';

class GenerateQRCode extends StatelessWidget {
  final screenshotController = ScreenshotController();
  final String data;

  GenerateQRCode({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff008e9b),
          title: const Text('مشاركة الـ QR'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 15,
                            right: 15,
                            
                          ),
                          child: Text(
                            ' اهلا وسهلا بكم في مجمع ${user.userdata.realestates[0].compound} ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        QrImageView(
                          backgroundColor: Colors.white,
                          data: data,
                          size: 300,
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(
                              100,
                              100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning_rounded,
                                    color: Colors.amber,
                                    size: 25,
                                  ),
                                  Text(
                                    ' الـ QR صالح للاستخدام لمرة واحده فقط ',
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
                                    ' يرجى قراءة ال QR عند الخروج ',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 140,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color(0xff008e9b),
                    ),
                  ),
                  onPressed: _shareQrCode,
                  child: const Text(
                    'مشاركة الـ QR',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);
          Share.shareFiles([imagePath.path]);
        } catch (error) {
          print(error);
        }
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}
