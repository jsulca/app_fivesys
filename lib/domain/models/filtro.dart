// To parse this JSON data, do
//
//     final parametros = parametrosFromJson(jsonString);

import 'dart:convert';

Parametros parametrosFromJson(String str) =>
    Parametros.fromJson(json.decode(str));

String parametrosToJson(Parametros data) => json.encode(data.toJson());

class Parametros {
  Parametros({
    required this.organizaciones,
    required this.categorias,
    required this.configuracion,
  });

  List<Organizacione> organizaciones;
  List<Categoria> categorias;
  Configuracion configuracion;

  factory Parametros.fromJson(Map<String, dynamic> json) => Parametros(
        organizaciones: List<Organizacione>.from(
            json["organizaciones"].map((x) => Organizacione.fromJson(x))),
        categorias: List<Categoria>.from(
            json["categorias"].map((x) => Categoria.fromJson(x))),
        configuracion: Configuracion.fromJson(json["configuracion"]),
      );

  Map<String, dynamic> toJson() => {
        "organizaciones":
            List<dynamic>.from(organizaciones.map((x) => x.toJson())),
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
        "configuracion": configuracion.toJson(),
      };
}

class Categoria {
  Categoria({
    required this.categoriaId,
    required this.nombre,
    required this.componentes,
  });

  int categoriaId;
  String nombre;
  List<Componente> componentes;

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        categoriaId: json["categoriaId"],
        nombre: json["nombre"],
        componentes: List<Componente>.from(
            json["componentes"].map((x) => Componente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoriaId": categoriaId,
        "nombre": nombre,
        "componentes": List<dynamic>.from(componentes.map((x) => x.toJson())),
      };
}

class Componente {
  Componente({
    required this.categoriaId,
    required this.componenteId,
    required this.nombre,
  });

  int categoriaId;
  int componenteId;
  String nombre;

  factory Componente.fromJson(Map<String, dynamic> json) => Componente(
        categoriaId: json["categoriaId"],
        componenteId: json["componenteId"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "categoriaId": categoriaId,
        "componenteId": componenteId,
        "nombre": nombre,
      };
}

class Configuracion {
  Configuracion({
    required this.valorS1,
    required this.valorS2,
    required this.valorS3,
    required this.valorS4,
    required this.valorS5,
  });

  int valorS1;
  int valorS2;
  int valorS3;
  int valorS4;
  int valorS5;

  factory Configuracion.fromJson(Map<String, dynamic> json) => Configuracion(
        valorS1: json["valorS1"],
        valorS2: json["valorS2"],
        valorS3: json["valorS3"],
        valorS4: json["valorS4"],
        valorS5: json["valorS5"],
      );

  Map<String, dynamic> toJson() => {
        "valorS1": valorS1,
        "valorS2": valorS2,
        "valorS3": valorS3,
        "valorS4": valorS4,
        "valorS5": valorS5,
      };
}

class Organizacione {
  Organizacione({
    required this.organizacionId,
    required this.nombre,
    required this.areas,
  });

  int organizacionId;
  String nombre;
  List<Area> areas;

  factory Organizacione.fromJson(Map<String, dynamic> json) => Organizacione(
        organizacionId: json["organizacionId"],
        nombre: json["nombre"],
        areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "organizacionId": organizacionId,
        "nombre": nombre,
        "areas": List<dynamic>.from(areas.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    required this.organizacionId,
    required this.areaId,
    required this.nombre,
    required this.sectores,
  });

  int organizacionId;
  int areaId;
  String nombre;
  List<Sectore> sectores;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        organizacionId: json["organizacionId"],
        areaId: json["areaId"],
        nombre: json["nombre"],
        sectores: List<Sectore>.from(
            json["sectores"].map((x) => Sectore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "organizacionId": organizacionId,
        "areaId": areaId,
        "nombre": nombre,
        "sectores": List<dynamic>.from(sectores.map((x) => x.toJson())),
      };
}

class Sectore {
  Sectore({
    required this.areaId,
    required this.sectorId,
    required this.nombre,
    required this.puntosFijos,
    required this.responsables,
  });

  int areaId;
  int sectorId;
  String nombre;
  List<PuntosFijo> puntosFijos;
  List<Responsable> responsables;

  factory Sectore.fromJson(Map<String, dynamic> json) => Sectore(
        areaId: json["areaId"],
        sectorId: json["sectorId"],
        nombre: json["nombre"],
        puntosFijos: List<PuntosFijo>.from(
            json["puntosFijos"].map((x) => PuntosFijo.fromJson(x))),
        responsables: List<Responsable>.from(
            json["responsables"].map((x) => Responsable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areaId": areaId,
        "sectorId": sectorId,
        "nombre": nombre,
        "puntosFijos": List<dynamic>.from(puntosFijos.map((x) => x.toJson())),
        "responsables": List<dynamic>.from(responsables.map((x) => x.toJson())),
      };
}

class PuntosFijo {
  PuntosFijo({
    required this.sectorId,
    required this.puntoFijoId,
    required this.nombre,
  });

  int sectorId;
  int puntoFijoId;
  String nombre;

  factory PuntosFijo.fromJson(Map<String, dynamic> json) => PuntosFijo(
        sectorId: json["sectorId"],
        puntoFijoId: json["puntoFijoId"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "sectorId": sectorId,
        "puntoFijoId": puntoFijoId,
        "nombre": nombre,
      };
}

class Responsable {
  Responsable({
    required this.responsableId,
    required this.sectorId,
    required this.nombreCompleto,
  });

  int responsableId;
  int sectorId;
  String nombreCompleto;

  factory Responsable.fromJson(Map<String, dynamic> json) => Responsable(
        responsableId: json["responsableId"],
        sectorId: json["sectorId"],
        nombreCompleto: json["nombreCompleto"],
      );

  Map<String, dynamic> toJson() => {
        "responsableId": responsableId,
        "sectorId": sectorId,
        "nombreCompleto": nombreCompleto,
      };
}
