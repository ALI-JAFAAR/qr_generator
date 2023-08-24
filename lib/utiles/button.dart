// ignore_for_file: file_names

import '/constants.dart';
import 'package:flutter/material.dart';

class CoustemButton extends StatelessWidget {
  const CoustemButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.width,
      required this.hight,
      required this.border,
      required this.margen})
      : super(key: key);

  final String title;
  final VoidCallback onTap;
  final double width, hight, border;
  final double margen;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(margen),
        height: hight,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(border),
          color: kPrimarycolor,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
