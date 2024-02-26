import 'package:dio/dio.dart';

class DioInstance {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.mail.tm',
  ));
}
