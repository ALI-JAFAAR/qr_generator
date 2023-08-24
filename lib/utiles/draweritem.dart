// ignore_for_file: prefer_const_constructors, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItemss extends StatelessWidget {
  const DrawerItemss({Key? key, required this.title,required this.myIcon,required this.onTap, this.color})
      : super(key: key);

  final String title;
  final IconData myIcon;
  final VoidCallback onTap;
  final color;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(right: 20),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(
                myIcon,
                color: color,
                size: 24,
              ),
              SizedBox(
                width: 28,
              ),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Icon(
                FontAwesomeIcons.angleLeft,
                color: color,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
