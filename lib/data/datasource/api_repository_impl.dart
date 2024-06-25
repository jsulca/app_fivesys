import 'dart:convert';
import 'package:app_fivesys/data/repository/api_repository.dart';
import 'package:http/http.dart' as http;

//const String _url = 'http://alphaman-001-site12.ftempurl.com';
const String _url = 'https://free.auditoria5s.com';

class ApiRepositoryImpl extends ApiRepository {
  @override
  Future<http.Response> getLogin(Map<String, String> q) async {
    final resp = await http.post(
      Uri.parse('$_url/api/usuario/login'),
      body: jsonEncode(q),
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> getRegister(Map<String, Object> q) async {
    final resp = await http.post(
      Uri.parse('$_url/Account/APIRegister'),
      body: jsonEncode(q),
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> changePass(String token, Map<String, Object> q) async {
    final resp = await http.post(
      Uri.parse('$_url/api/usuario/cambiarclave'),
      body: jsonEncode(q),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> sendRegistro(
      String token, Map<String, String> q) async {
    final resp = await http.post(
      Uri.parse('$_url/Account/APIRegister'),
      body: jsonEncode(q),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> getAuditoriasByOne(String token, int id) async {
    final resp = await http.get(
      Uri.parse('$_url/api/auditoria/buscar?id=$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> saveHeader(String token, Map<String, dynamic> q) async {
    final resp = await http.post(
      Uri.parse('$_url/api/auditoria/guardarcabecera'),
      body: jsonEncode(q),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> getFiltroGetAll(String token) async {
    final resp = await http.get(
      Uri.parse('$_url/api/auditoria/obtenerparametros'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> sendRegister(
      String token, Map<String, String> q, List<String> f) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache',
    };
    final request = http.MultipartRequest(
        'POST', Uri.parse('$_url/api/auditoria/actualizar'));

    request.fields.addAll(q);

    for (var element in f) {
      request.files.add(await http.MultipartFile.fromPath('fotos', element));
    }

    request.headers.addAll(headers);

    final http.StreamedResponse streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    return response;
  }

  @override
  Future<http.Response> pagination(String token, Map<String, dynamic> q) async {
    final resp = await http.post(
      Uri.parse('$_url/api/auditoria/listar'),
      body: jsonEncode(q),
      headers: {
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> sendEmail(String token, int id, String email) async {
    final resp = await http.get(
      Uri.parse('$_url/api/auditoria/enviarcorreo?id=$id&correo=$email'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> getOffLine(String token) async {
    final resp = await http.post(
      Uri.parse('$_url/Home/APIGetData'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> sendRegisterOffLine(
      String token, Map<String, String> q, List<String> f) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache',
    };
    final request =
        http.MultipartRequest('POST', Uri.parse('$_url/api/auditoria/offline'));

    request.fields.addAll(q);

    for (var element in f) {
      request.files.add(await http.MultipartFile.fromPath('fotos', element));
    }

    request.headers.addAll(headers);

    final http.StreamedResponse streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    return response;
  }

  @override
  Future<http.Response> getDownloadPdf(String token, int id) async {
    final resp = await http.get(
      Uri.parse('$_url/api/auditoria/reportepdf?id=$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }

  @override
  Future<http.Response> getDownloadImage(String token, int id) async {
    final resp = await http.get(
      Uri.parse('$_url/api/adjunto/buscar?id=$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
      },
    );
    return resp;
  }
}
