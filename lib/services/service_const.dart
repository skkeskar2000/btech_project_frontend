
import 'package:dio/dio.dart';

class Tuple{
  final bool status;
  final String msg;
  Tuple({required this.status, required this.msg});
}

Dio dio() {
  final dio = Dio();
  // dio.options.headers["Accept"] =
  // "application/json"; // config your dio headers globally
  dio.options.followRedirects = false;
  dio.options.connectTimeout = 75000; //5s
  dio.options.receiveTimeout = 3000;
  return dio;
}
