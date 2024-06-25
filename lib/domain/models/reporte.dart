// To parse this JSON data, do
//
//     final reportes = reportesFromJson(jsonString);

import 'dart:convert';

Reportes reporteFromJson(String str) =>
    Reportes.fromJson(json.decode(str) as Map<String, dynamic>);

String reportesToJson(Reportes data) => json.encode(data.toJson());

class Reportes {
  Reportes({
    this.avisos = const [],
    this.ordenesTrabajo = const [],
  });

  List<Reporte> avisos;
  List<Reporte> ordenesTrabajo;

  factory Reportes.fromJson(Map<String, dynamic> json) => Reportes(
        avisos: List<Reporte>.from(json["avisos"]
                .map((x) => Reporte.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        ordenesTrabajo: List<Reporte>.from(json["ordenesTrabajo"]
                .map((x) => Reporte.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "avisos": List<dynamic>.from(avisos.map((x) => x.toJson())),
        "ordenesTrabajo":
            List<dynamic>.from(ordenesTrabajo.map((x) => x.toJson())),
      };
}

class Reporte {
  Reporte({
    this.estado = "",
    this.cantidad = 0,
    this.color = "",
  });

  String estado = "";
  int cantidad = 0;
  String color = "";

  factory Reporte.fromJson(Map<String, dynamic> json) => Reporte(
        estado: json["estado"] as String,
        cantidad: json["cantidad"] as int,
        color: json["color"] as String,
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "cantidad": cantidad,
        "color": color,
      };
}

List<Reporte> avisos = [
  Reporte(estado: "EMITIDO", cantidad: 10, color: "#d0cece"),
  Reporte(estado: "LIBERADO", cantidad: 5, color: "#4472c4"),
  Reporte(estado: "APROBADO", cantidad: 20, color: "#00b050"),
  Reporte(estado: "ATENDIDO", cantidad: 16, color: "#00803a"),
];

List<Reporte> ordenesTrabajo = [
  Reporte(estado: "EJECUCIÓN", cantidad: 10, color: "#ffc000"),
  Reporte(estado: "CIERRE TÉCNICO", cantidad: 5, color: "#005384")
];
