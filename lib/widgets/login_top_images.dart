import 'package:flutter/material.dart';

class Login_top_images extends StatelessWidget {
  const Login_top_images({
    Key? key,
    required double height,
    required double width,
  })  : _height = height,
        _width = width,
        super(key: key);

  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Painter(),
      child: Container(
        height: _height * 0.35,
        width: _width,
        decoration: BoxDecoration(gradient: buildLinearGradient()),
        child: Stack(
          children: [
           Align(
                child: Image.asset(
                  'assets/images/login_man.png',
                  width: _width * 0.85,
                  height: _height * 0.25,
                ),
                alignment: Alignment.bottomCenter,
              ),
            Positioned(
                top: 10,
                right: _width * 0.2,
                child: Image.asset(
                  'assets/images/cloud.png',
                  height: 60,
                )),
            Positioned(
                top: 40,
                right: _width * 0.65,
                child: Image.asset(
                  'assets/images/cloud.png',
                  height: 50,
                )),
            Positioned(
                top: 80,
                left: -10,
                child: Image.asset(
                  'assets/images/cloud.png',
                  height: 70,
                )),
            Positioned(
                bottom: 100,
                right: _width * 0.03,
                child: Image.asset(
                  'assets/images/cloud.png',
                  height: 50,
                ))
          ],
        ),
      ),
    );
  }

  LinearGradient buildLinearGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(1, 1.2), // 10% of the width, so there are ten blinds.
      stops: [0.1, 0.2, 0.4, 0.6, 0.8, 2],
      colors: const <Color>[
        Color(0xff9896F1),
        Color(0xffBE99F4),
        Color(0xffD59BF6),
        Color(0xffE2A7F3),
        Color(0xffEDB1F1),
        Color(0xffEDD5EF)
      ], // red to yellow
      tileMode: TileMode.decal, // repeats the gradient over the canvas
    );
  }
}

class Painter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    Path path = Path();
    // Path number 1
    paint.color = Color(0xffffffff).withOpacity(0);
    path = Path();
    path.lineTo(size.width * 0.32, size.height * 0.76);
    path.cubicTo(size.width * 0.28, size.height * 0.76, size.width * 0.15,
        size.height * 0.74, size.width * 0.06, size.height * 0.96);
    path.cubicTo(size.width * 0.05, size.height, size.width * 0.03, size.height,
        0, size.height);
    path.cubicTo(0, size.height, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.98, size.width,
        size.height * 0.98);
    path.cubicTo(size.width * 0.98, size.height * 0.97, size.width * 0.97,
        size.height * 0.96, size.width * 0.95, size.height * 0.94);
    path.cubicTo(size.width * 0.91, size.height * 0.86, size.width * 0.91,
        size.height * 0.84, size.width * 0.88, size.height * 0.8);
    path.cubicTo(size.width * 0.83, size.height * 0.73, size.width * 0.74,
        size.height * 0.75, size.width * 0.68, size.height * 0.78);
    path.cubicTo(size.width * 0.6, size.height * 0.83, size.width * 0.53,
        size.height * 0.85, size.width * 0.48, size.height * 0.82);
    path.cubicTo(size.width * 0.41, size.height * 0.77, size.width * 0.36,
        size.height * 0.76, size.width * 0.32, size.height * 0.76);
    path.cubicTo(size.width * 0.32, size.height * 0.76, size.width * 0.32,
        size.height * 0.76, size.width * 0.32, size.height * 0.76);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
