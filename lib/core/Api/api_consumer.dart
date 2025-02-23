abstract class ApiConsumer {
  Future<dynamic> get(String path,
      {Object? data, Map<String, dynamic>? quaryParameter});
  Future<dynamic> post(String path,
      {Object? data, Map<String, dynamic>? quaryParameter, bool isFormData});
  Future<dynamic> patshe(String path,
      {Object? data, Map<String, dynamic>? quaryParameter, bool isFormData});
  Future<dynamic> delete(String path,
      {Object? data, Map<String, dynamic>? quaryParameter, bool isFormData});
}
