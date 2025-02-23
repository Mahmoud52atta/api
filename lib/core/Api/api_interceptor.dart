import 'package:api/cashe/helper_cache.dart';
import 'package:api/core/Api/endPoints.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = CacheHelper().getData(key: ApiKey.token);
    print("Token being sent: $token");
    options.headers[ApiKey.token] =
        CacheHelper().getData(key: ApiKey.token) != null
            ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
