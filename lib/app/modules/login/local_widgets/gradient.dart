import 'package:flutter/material.dart';

LinearGradient buildLinearGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(
        1, 1.2), // 10% of the width, so there are ten blinds.
    stops: [0.1, 0.2, 0.4, 0.6, 0.8, 2],
    colors: const <Color>[
      Color(0xff9896F1),
      Color(0xffBE99F4),
      Color(0xffD59BF6),
      Color(0xffE2A7F3),
      Color(0xffEDB1F1),
      Color(0xffEDD5EF)
    ], // red to yellow
    tileMode:
    TileMode.decal, // repeats the gradient over the canvas
  );
}