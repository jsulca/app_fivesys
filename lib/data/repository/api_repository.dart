import 'package:http/http.dart' as http;

abstract class ApiRepository {
  // Account
  Future<http.Response> getLogin(Map<String, String> q);
  Future<http.Response> getRegister(Map<String, Object> q);
  Future<http.Response> changePass(String token, Map<String, Object> q);
  Future<http.Response> sendRegistro(String token, Map<String, String> q);

  // Auditoria
  Future<http.Response> getAuditoriasByOne(String token, int id);
  Future<http.Response> saveHeader(String token, Map<String, dynamic> q);
  Future<http.Response> getFiltroGetAll(String token);
  Future<http.Response> sendRegister(
      String token, Map<String, String> q, List<String> f);
  Future<http.Response> pagination(String token, Map<String, dynamic> q);
  Future<http.Response> sendEmail(String token, int id, String email);

  // Modo Off-Line
  Future<http.Response> getOffLine(String token);
  Future<http.Response> sendRegisterOffLine(
      String token, Map<String, String> q, List<String> f);

  //Pdf
  Future<http.Response> getDownloadPdf(String token, int id);
  Future<http.Response> getDownloadImage(String token, int id);
}
