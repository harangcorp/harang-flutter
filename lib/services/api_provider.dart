import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_rx/get_rx.dart';
import 'package:harang/models/nuri.dart';

class NuriAPI {
  final Dio _dio = Get.find<Dio>();

  Future<Nuri> postReq(String code, {String? input = ""}) async {
    Response response = await _dio.post(
        'https://suth1jsg3l.execute-api.ap-northeast-2.amazonaws.com/production/run',
        data: {"code": code, "input": input});
    return Nuri.fromJson(response.data);
  }
}
