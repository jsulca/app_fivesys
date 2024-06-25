// To parse this JSON data, do
// Offline = FiltrolineFromJson(jsonString);

import 'dart:convert';

import 'package:floor/floor.dart';

import 'convert.dart';

Offline offlineFromJson(String str) => Offline.fromJson(json.decode(str));

String offlineToJson(Offline data) => json.encode(data.toJson());

class Offline {
  Offline({
    required this.organizaciones,
    required this.categorias,
    required this.configuracion,
  });

  List<OrganizacionFiltro> organizaciones;
  List<CategoriaFiltro> categorias;
  ConfiguracionFiltro configuracion;

  factory Offline.fromJson(Map<String, dynamic> json) => Offline(
        organizaciones: List<OrganizacionFiltro>.from(
            json["organizaciones"].map((x) => OrganizacionFiltro.fromJson(x))),
        categorias: List<CategoriaFiltro>.from(
            json["categorias"].map((x) => CategoriaFiltro.fromJson(x))),
        configuracion: ConfiguracionFiltro.fromJson(json["configuracion"]),
      );

  Map<String, dynamic> toJson() => {
        "organizaciones":
            List<dynamic>.from(organizaciones.map((x) => x.toJson())),
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
        "configuracion": configuracion.toJson(),
      };
}

List<OrganizacionFiltro> organizacionFromJson(String str) =>
    List<OrganizacionFiltro>.from(
        json.decode(str).map((x) => OrganizacionFiltro.fromJson(x)));

String organizacionToJson(List<OrganizacionFiltro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@TypeConverters([
  AreaFiltroConverter,
])
@entity
class OrganizacionFiltro {
  OrganizacionFiltro({
    required this.organizacionId,
    required this.nombre,
    this.areas = const [],
  });

  @primaryKey
  int organizacionId;
  String nombre;
  List<AreaFiltro>? areas;

  factory OrganizacionFiltro.fromJson(Map<String, dynamic> json) =>
      OrganizacionFiltro(
        organizacionId: json["organizacionId"],
        nombre: json["nombre"],
        areas: List<AreaFiltro>.from(
            json["areas"].map((x) => AreaFiltro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "organizacionId": organizacionId,
        "nombre": nombre,
        "areas": List<dynamic>.from(areas!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return nombre;
  }
}

List<AreaFiltro> areaFromJson(String str) =>
    List<AreaFiltro>.from(json.decode(str).map((x) => AreaFiltro.fromJson(x)));

String areaToJson(List<AreaFiltro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaFiltro {
  AreaFiltro({
    required this.areaId,
    required this.nombre,
    this.sectores = const [],
  });

  int areaId;
  String nombre;
  List<SectorFiltro>? sectores;

  factory AreaFiltro.fromJson(Map<String, dynamic> json) => AreaFiltro(
        areaId: json["areaId"],
        nombre: json["nombre"],
        sectores: List<SectorFiltro>.from(
            json["sectores"].map((x) => SectorFiltro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areaId": areaId,
        "nombre": nombre,
        "sectores": List<dynamic>.from(sectores!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return nombre;
  }
}

class SectorFiltro {
  SectorFiltro({
    this.areaId = 0,
    this.sectorId = 0,
    this.nombre = '',
    this.puntosFijos = const [],
    this.responsables = const [],
  });

  int sectorId;
  int areaId;
  String nombre;
  List<PuntosFijoFiltro>? puntosFijos;
  List<ResponsableFiltro>? responsables;

  factory SectorFiltro.fromJson(Map<String, dynamic> json) => SectorFiltro(
        areaId: json["areaId"],
        sectorId: json["sectorId"],
        nombre: json["nombre"],
        puntosFijos: List<PuntosFijoFiltro>.from(
            json["puntosFijos"].map((x) => PuntosFijoFiltro.fromJson(x))),
        responsables: List<ResponsableFiltro>.from(
            json["responsables"].map((x) => ResponsableFiltro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areaId": areaId,
        "sectorId": sectorId,
        "nombre": nombre,
        "puntosFijos": List<dynamic>.from(puntosFijos!.map((x) => x.toJson())),
        "responsables":
            List<dynamic>.from(responsables!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return nombre;
  }
}

class PuntosFijoFiltro {
  PuntosFijoFiltro({
    required this.sectorId,
    required this.puntoFijoId,
    required this.nombre,
  });

  int puntoFijoId;
  int? sectorId;
  String nombre;

  factory PuntosFijoFiltro.fromJson(Map<String, dynamic> json) =>
      PuntosFijoFiltro(
        sectorId: json["sectorId"],
        puntoFijoId: json["puntoFijoId"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "sectorId": sectorId,
        "puntoFijoId": puntoFijoId,
        "nombre": nombre,
      };

  @override
  String toString() {
    return nombre;
  }
}

class ResponsableFiltro {
  ResponsableFiltro({
    this.responsableId = 0,
    this.sectorId = 0,
    this.nombreCompleto = '',
  });

  int responsableId;
  int? sectorId;
  String nombreCompleto;

  factory ResponsableFiltro.fromJson(Map<String, dynamic> json) =>
      ResponsableFiltro(
        responsableId: json["responsableId"],
        sectorId: json["sectorId"],
        nombreCompleto: json["nombreCompleto"],
      );

  Map<String, dynamic> toJson() => {
        "responsableId": responsableId,
        "sectorId": sectorId,
        "nombreCompleto": nombreCompleto,
      };

  @override
  String toString() {
    return nombreCompleto;
  }
}

@TypeConverters([
  ComponenteFiltroConverter,
])
@entity
class CategoriaFiltro {
  CategoriaFiltro({
    required this.categoriaId,
    required this.nombre,
    required this.componentes,
  });

  @primaryKey
  int categoriaId;
  String nombre;
  List<ComponenteFiltro>? componentes;

  factory CategoriaFiltro.fromJson(Map<String, dynamic> json) =>
      CategoriaFiltro(
        categoriaId: json["categoriaId"],
        nombre: json["nombre"],
        componentes: List<ComponenteFiltro>.from(
            json["componentes"].map((x) => ComponenteFiltro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoriaId": categoriaId,
        "nombre": nombre,
        "componentes": List<dynamic>.from(componentes!.map((x) => x.toJson())),
      };
}

class ComponenteFiltro {
  ComponenteFiltro({
    required this.categoriaId,
    required this.componenteId,
    required this.nombre,
  });

  int categoriaId;
  int componenteId;
  String nombre;

  factory ComponenteFiltro.fromJson(Map<String, dynamic> json) =>
      ComponenteFiltro(
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

@entity
class ConfiguracionFiltro {
  ConfiguracionFiltro({
    required this.valorS1,
    required this.valorS2,
    required this.valorS3,
    required this.valorS4,
    required this.valorS5,
  });
  @primaryKey
  int valorS1;
  int valorS2;
  int valorS3;
  int valorS4;
  int valorS5;

  factory ConfiguracionFiltro.fromJson(Map<String, dynamic> json) =>
      ConfiguracionFiltro(
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

// To parse this JSON data, do
//
//      filtro = filtroFromJson(jsonString);

Filtro filtroFromJson(String str) => Filtro.fromJson(json.decode(str));

String filtroToJson(Filtro data) => json.encode(data.toJson());

class Filtro {
  Filtro({
    this.areaId = 0,
    this.auditorId = 0,
    this.codigo = '',
    this.estado = 0,
    this.nombre = '',
    this.responsableId = 0,
    this.sectorId = 0,
    this.areaNombre = '',
    this.sectorNombre = '',
    this.pageIndex = 0,
    this.pageSize = 0,
    this.organizacionId = 0,
    this.organizacionNombre = '',
    this.responsable = '',
    this.sector = '',
    this.area = '',
    this.s1 = true,
    this.s2 = true,
    this.s3 = true,
    this.s4 = true,
    this.s5 = true,
    this.valorNegativo = false,
  });

  int areaId;
  int auditorId;
  String codigo;
  int estado;
  String nombre;
  int responsableId;
  int sectorId;
  int pageIndex;
  int pageSize;
  int organizacionId;

  String area;
  String sector;
  String responsable;
  String organizacionNombre;
  String areaNombre;
  String sectorNombre;

  bool s1;
  bool s2;
  bool s3;
  bool s4;
  bool s5;
  bool valorNegativo;

  factory Filtro.fromJson(Map<String, dynamic> json) => Filtro(
        areaId: json["areaId"],
        auditorId: json["auditorId"],
        codigo: json["codigo"],
        estado: json["estado"],
        nombre: json["nombre"],
        responsableId: json["responsableId"],
        sectorId: json["sectorId"],
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        organizacionId: json["organizacionId"],
        s1: json["s1"],
        s2: json["s2"],
        s3: json["s3"],
        s4: json["s4"],
        s5: json["s5"],
        valorNegativo: json["valorNegativo"],
      );

  Map<String, dynamic> toJson() => {
        "areaId": areaId,
        "auditorId": auditorId,
        "codigo": codigo,
        "estado": estado,
        "nombre": nombre,
        "responsableId": responsableId,
        "sectorId": sectorId,
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "organizacionId": organizacionId,
        "s1": s1,
        "s2": s2,
        "s3": s3,
        "s4": s4,
        "s5": s5,
        "valorNegativo": valorNegativo,
      };
}
