// ignore_for_file: file_names

import 'package:flutter/material.dart';

class IconsButton extends StatelessWidget {
  const IconsButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.width,
    required this.hight,
    required this.border,
    required this.margen,
    required this.size,
    required this.color,
  }) : super(key: key);

  final IconData title;
  final VoidCallback onTap;
  final double width, hight, border, size;
  final double margen;
  final Color color;
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
          // color: Colors.amber,
          border: Border.all(width: 2)
        ),
        child: Center(
          child: Icon(
            title,
            size: size,
            color: color,
          ),
        ),
      ),
    );
  }
}
