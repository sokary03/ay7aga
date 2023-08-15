import 'package:dio/dio.dart';

class DioHelper
{

  static Dio? dio;

  static init()
  {

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio?.options.headers = {
      'Authorization':token??'',
      'Content-Type':'application/json',
    };

    return await dio!.get(url);
  }





  static Future<Response>? postData({
    required String url,
    required Map<String,dynamic>? data,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? token,

}){
    dio?.options.headers = {
      'lang':'en',
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return dio?.post(
        url,
        data: data,
      queryParameters: query,
    );
  }


  static Future<Response>? putData({
    required String url,
    required Map<String,dynamic>? data,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? token,

  }){
    dio?.options.headers = {
      'lang':'en',
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return dio?.put(
      url,
      data: data,
      queryParameters: query,
    );
  }






}