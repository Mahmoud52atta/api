import 'package:api/core/Api/api_consumer.dart';
import 'package:api/core/Api/endPoints.dart';
import 'package:api/core/errors/exception.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(Interceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? quaryParameter,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quaryParameter);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? quaryParameter}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: quaryParameter,
        // options: Options(
        //   headers: {
        //     "Authorization":
        //         "FOODAPI m${CacheHelper().getData(key: ApiKey.token)}",
        //     "Accept": "application/json",
        //   },
        // ),
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future patshe(String path,
      {dynamic data,
      Map<String, dynamic>? quaryParameter,
      bool isFormData = false}) async {
    try {
      final response = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quaryParameter);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? quaryParameter,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quaryParameter);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }
}
