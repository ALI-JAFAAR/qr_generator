// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
              const SizedBox(height: 50,),
              Expanded(
                child: Screenshot(
                  controller: screenshotController,
                  child: QrImageView(
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
                height: 200,
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
