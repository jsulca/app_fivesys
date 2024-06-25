// To parse this JSON data, do
//
//     final badResponse = badResponseFromJson(jsonString);

import 'dart:convert';

BadResponse badResponseFromJson(String str) =>
    BadResponse.fromJson(json.decode(str));

String badResponseToJson(BadResponse data) => json.encode(data.toJson());

class BadResponse {
  BadResponse({
    this.errores = const [],
  });

  List<String> errores;

  factory BadResponse.fromJson(Map<String, dynamic> json) => BadResponse(
        errores: List<String>.from(json["errores"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "errores": List<dynamic>.from(errores.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final unauthorized = unauthorizedFromJson(jsonString);

Unauthorized unauthorizedFromJson(String str) =>
    Unauthorized.fromJson(json.decode(str));

String unauthorizedToJson(Unauthorized data) => json.encode(data.toJson());

class Unauthorized {
  Unauthorized({
    this.type = '',
    this.title = '',
    this.status = 0,
    this.traceId = '',
  });

  String type;
  String title;
  int status;
  String traceId;

  factory Unauthorized.fromJson(Map<String, dynamic> json) => Unauthorized(
        type: json["type"],
        title: json["title"],
        status: json["status"],
        traceId: json["traceId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "status": status,
        "traceId": traceId,
      };
}

SuccessResponse successResponseFromJson(String str) =>
    SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) =>
    json.encode(data.toJson());

class SuccessResponse {
  SuccessResponse({
    this.mensaje = '',
  });

  String mensaje;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
        mensaje: json["mensaje"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
      };
}
