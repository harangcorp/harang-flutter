import 'package:flutter/material.dart';

class Painter extends CustomClipper<Path>  {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    Path path = Path();
    // Path number 1
    paint.color = Color(0xffffffff).withOpacity(0);
    path = Path();
    path.lineTo(size.width * 0.32, size.height * 0.76);
    path.cubicTo(size.width * 0.28, size.height * 0.76, size.width * 0.15, size.height * 0.74, size.width * 0.06, size.height * 0.96);
    path.cubicTo(size.width * 0.05, size.height, size.width * 0.03, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.98, size.width, size.height * 0.98);
    path.cubicTo(size.width * 0.98, size.height * 0.97, size.width * 0.97, size.height * 0.96, size.width * 0.95, size.height * 0.94);
    path.cubicTo(size.width * 0.91, size.height * 0.86, size.width * 0.91, size.height * 0.84, size.width * 0.88, size.height * 0.8);
    path.cubicTo(size.width * 0.83, size.height * 0.73, size.width * 0.74, size.height * 0.75, size.width * 0.68, size.height * 0.78);
    path.cubicTo(size.width * 0.6, size.height * 0.83, size.width * 0.53, size.height * 0.85, size.width * 0.48, size.height * 0.82);
    path.cubicTo(size.width * 0.41, size.height * 0.77, size.width * 0.36, size.height * 0.76, size.width * 0.32, size.height * 0.76);
    path.cubicTo(size.width * 0.32, size.height * 0.76, size.width * 0.32, size.height * 0.76, size.width * 0.32, size.height * 0.76);

    return path;
  }


  @override
  bool shouldReclip(CustomClipper oldClipper) {
   return true;
  }
}
