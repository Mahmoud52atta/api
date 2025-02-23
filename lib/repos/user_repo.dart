import 'package:api/cashe/helper_cache.dart';
import 'package:api/core/Api/api_consumer.dart';
import 'package:api/core/Api/endPoints.dart';
import 'package:api/core/errors/exception.dart';
import 'package:api/core/functions/upload_image_to_api.dart';
import 'package:api/models/signUp_model.dart';
import 'package:api/models/signin_model.dart';
import 'package:api/models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepo {
  final ApiConsumer api;

  UserRepo({required this.api});
  Future<Either<String, SignInModel>> signIn(
      {required String email, required String password}) async {
    try {
      final response = await api.post(Endpoints.signIn,
          data: {ApiKey.email: email, ApiKey.password: password});
      final user = SignInModel.formJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return right(user);
    } on ServerException catch (e) {
      return left(e.erroreModel.erroreMessage);
    }
  }

  Future<Either<String, SignUpModel>> signUp(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required XFile profilePic}) async {
    try {
      final response = await api.post(
        Endpoints.signUp,
        isFormData: true,
        data: {
          ApiKey.name: name,
          ApiKey.email: email,
          ApiKey.phone: phone,
          ApiKey.password: password,
          ApiKey.confirmPassword: confirmPassword,
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKey.profilePic: uploadImageToAPI(profilePic),
        },
      );
      final signInModel = SignUpModel.formJson(response);
      return right(signInModel);
    } on ServerException catch (e) {
      return left(e.erroreModel.erroreMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        Endpoints.userDataId(
          CacheHelper().getData(key: ApiKey.id),
        ),
      );
      if (response == null) {
        return Left("Empty response received");
      }
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.erroreModel.erroreMessage);
    }
  }
}
