import 'package:api/core/errors/errore_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErroreModel erroreModel;

  ServerException({required this.erroreModel});
}

void handelDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          erroreModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(
          erroreModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(
          erroreModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(
          erroreModel: e.response!.data); // TODO: Handle this case.
    case DioExceptionType.cancel:
      throw ServerException(
          erroreModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(
          erroreModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(
          erroreModel: ErroreModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
        case 404: //not found
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
        case 409: //cofficient
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
        case 422: //  Unprocessable Entity
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
        case 504: // Server exception
          throw ServerException(
              erroreModel: ErroreModel.fromJson(e.response!.data));
      }
  }
}
