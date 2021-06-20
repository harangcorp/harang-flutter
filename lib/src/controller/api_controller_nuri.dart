import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';

const _API_PREFIX = 'https://suth1jsg3l.execute-api.ap-northeast-2.amazonaws.com/production/run';

const _test_code = '꾸러미 "유용한 함수들.nuri"\n동사 [ㄱ]을 [ㄴ]으로 나누다: [ㄱ] / [ㄴ]\n10을 5로 나누고 보여주다';

class Server {
  Future postReq(String code) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post(_API_PREFIX, data: {"code": code, "input": ""});
    return response.data['output'] ;
  }
}

Server server = Server();