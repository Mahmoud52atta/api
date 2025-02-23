import 'package:api/core/Api/endPoints.dart';

class ErroreModel {
  final int stutuseCode;
  final String erroreMessage;

  ErroreModel({required this.stutuseCode, required this.erroreMessage});
  factory ErroreModel.fromJson(Map<String, dynamic> jsonData) {
    return ErroreModel(
      stutuseCode: jsonData[ApiKey.status],
      erroreMessage: jsonData[ApiKey.errorMessage],
    );
  }
}
