import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class Nuri {
  Nuri({
    required this.output,
  });

  final String output;

  factory Nuri.fromJson(Map<String, dynamic> json) => Nuri(
        output: json["output"],
      );

  Map<String, dynamic> toJson() => {
        "output": output,
      };
}
