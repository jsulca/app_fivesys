// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';
import 'package:floor/floor.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

@entity
class Usuario {
  Usuario({
    this.auditorId = 0,
    this.nombreCompleto = '',
    this.correo = '',
    this.token = '',
    this.cambiarClave = false,
  });
  @primaryKey
  int auditorId;
  String nombreCompleto;
  String correo;
  String token;
  bool cambiarClave;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        auditorId: json["auditorId"],
        nombreCompleto: json["nombreCompleto"],
        correo: json["correo"],
        token: json["token"],
        cambiarClave: json["cambiarClave"],
      );

  Map<String, dynamic> toJson() => {
        "auditorId": auditorId,
        "nombreCompleto": nombreCompleto,
        "correo": correo,
        "token": token,
        "cambiarClave": cambiarClave,
      };
}

List<TipoDocumento> tipoDocumentoFromJson(String str) =>
    List<TipoDocumento>.from(
        json.decode(str).map((x) => TipoDocumento.fromJson(x)));

String tipoDocumentoToJson(List<TipoDocumento> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoDocumento {
  TipoDocumento({
    required this.id,
    required this.nombre,
  });

  int id;
  String nombre;

  factory TipoDocumento.fromJson(Map<String, dynamic> json) => TipoDocumento(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };

  @override
  String toString() {
    return nombre;
  }
}

final tipoDocumentos = [
  TipoDocumento(id: 3, nombre: 'L.E / DNI'),
  TipoDocumento(id: 4, nombre: 'CARNET EXT.'),
  TipoDocumento(id: 5, nombre: 'RUC'),
  TipoDocumento(id: 6, nombre: 'PASAPORTE'),
  TipoDocumento(id: 7, nombre: 'P. NAC.'),
];

final sectores = [
  TipoDocumento(id: 3, nombre: 'Industrial'),
  TipoDocumento(id: 4, nombre: 'Comercial'),
  TipoDocumento(id: 5, nombre: 'Minero'),
  TipoDocumento(id: 6, nombre: 'Agricola'),
  TipoDocumento(id: 7, nombre: 'Estatal'),
  TipoDocumento(id: 7, nombre: 'Educativo'),
  TipoDocumento(id: 7, nombre: 'Otros'),
];

final tipoEstados = [
  TipoDocumento(id: 0, nombre: 'EMITIDO'),
  TipoDocumento(id: 1, nombre: 'PROGRAMADO'),
  TipoDocumento(id: 2, nombre: 'TERMINADO'),
  TipoDocumento(id: 3, nombre: 'ANULADO'),
];

String getEstado(int id) {
  if (id == 0) {
    return 'EMITIDO';
  }
  if (id == 1) {
    return 'PROGRAMADO';
  }
  if (id == 2) {
    return 'TERMINADO';
  }
  if (id == 3) {
    return 'ANULADO';
  }
  return '';
}
