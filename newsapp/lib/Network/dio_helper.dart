import 'package:dio/dio.dart';

//https://newsapi.org/v2/top-headlines?country=us&apiKey=dfdf1670386e4ae18358d74b803338f8
//GET https://newsapi.org/v2/everything?q=bitcoin&apiKey=dfdf1670386e4ae18358d74b803338f8

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ),
  );

  static Future<Response> getData(
      {required path, required Map<String, dynamic> query}) async {
    return await dio.get(path, queryParameters: query);
  }
}
