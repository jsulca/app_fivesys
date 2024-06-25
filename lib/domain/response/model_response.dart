import 'dart:convert';

ModelResponse modelResponseFromJson(String str) =>
    ModelResponse.fromJson(json.decode(str) as Map<String, dynamic>);

class ModelResponse {
  ModelResponse({
    required this.response,
    this.data,
  });
  Response response;
  Object? data;

  factory ModelResponse.fromJson(Map<String, dynamic> json) => ModelResponse(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        data: (json['data'] == null) ? Object() : json['data'] as Object,
      );
}

class Response {
  Response({
    required this.codigo,
    required this.descripcion,
    required this.comentario,
  });

  String codigo;
  String descripcion;
  String comentario;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        codigo: json['codigo'] as String,
        descripcion: json['descripcion'] as String,
        comentario: json['comentario'] as String,
      );
}

// To parse this JSON data, do
//
//     final resultResponse = resultResponseFromJson(jsonString);

ResultResponse resultResponseFromJson(String str) =>
    ResultResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String resultResponseToJson(ResultResponse data) => json.encode(data.toJson());

class ResultResponse {
  ResultResponse({
    this.id,
    this.mensaje,
  });

  int? id;
  String? mensaje;

  factory ResultResponse.fromJson(Map<String, dynamic> json) => ResultResponse(
      id: (json['id'] == null) ? 0 : json['id'] as int,
      mensaje: (json['mensaje'] == null) ? '' : json['mensaje'] as String);

  Map<String, dynamic> toJson() => {
        'id': id,
        'mensaje': mensaje,
      };
}

// Envio de Auditoria
// To parse this JSON data, do
//
// final auditoriaResponse = auditoriaResponseFromJson(jsonString);

AuditoriaResponse auditoriaResponseFromJson(String str) =>
    AuditoriaResponse.fromJson(json.decode(str));

String auditoriaResponseToJson(AuditoriaResponse data) =>
    json.encode(data.toJson());

class AuditoriaResponse {
  AuditoriaResponse({
    this.mensaje = '',
    this.ids = const [],
  });

  String mensaje;
  List<Id> ids;

  factory AuditoriaResponse.fromJson(Map<String, dynamic> json) =>
      AuditoriaResponse(
        mensaje: json["mensaje"],
        ids: List<Id>.from(json["ids"].map((x) => Id.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "ids": List<dynamic>.from(ids.map((x) => x.toJson())),
      };
}

class Id {
  Id({
    this.id = 0,
    this.auditoriaDetalleId = 0,
  });

  int id;
  int auditoriaDetalleId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["Id"],
        auditoriaDetalleId: json["AuditoriaDetalleId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "AuditoriaDetalleId": auditoriaDetalleId,
      };
}
