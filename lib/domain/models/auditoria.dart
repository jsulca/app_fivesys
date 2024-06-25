// To parse this JSON data, do
//
//     final auditoria = auditoriaFromJson(jsonString);

import 'dart:convert';

import 'package:floor/floor.dart';

import 'convert.dart';

Auditoria auditoriaFromJson(String str) => Auditoria.fromJson(json.decode(str));

String auditoriaToJson(Auditoria data) => json.encode(data.toJson());

List<Auditoria> auditoriasFromJson(String str) =>
    List<Auditoria>.from(json.decode(str).map((x) => Auditoria.fromJson(x)));

String auditoriasToJson(List<Auditoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@TypeConverters([
  SectorConverter,
  OrganizacionConverter,
  AreaConverter,
  GrupoConverter,
  ResponsableConverter,
  //ListDetalleConverter,
  //ListPuntosFijoConverter,
  ListCategoriaElementConverter,
  ConfiguracionConverter,
])
@entity
class Auditoria {
  Auditoria({
    this.auditoriaId = 0,
    this.codigo = '',
    this.nombre = '',
    this.estado = 0,
    this.responsableId = 0,
    this.auditorId = 0,
    this.s1 = false,
    this.s2 = false,
    this.s3 = false,
    this.s4 = false,
    this.s5 = false,
    this.fechaRegistro = '01/01/0001',
    this.fechaProgramado = '',
    this.organizacion,
    this.responsable,
    this.grupo,
    this.area,
    this.sector,
    this.detalles = const [],
    this.puntosFijos = const [],
    this.categorias = const [],
    this.configuracion,
    this.online = 0,
  });
  @PrimaryKey(autoGenerate: true)
  int auditoriaId;
  String codigo;
  String nombre;
  int estado;
  int? responsableId;
  int? auditorId;
  int? online;

  bool s1;
  bool s2;
  bool s3;
  bool s4;
  bool s5;

  String? fechaRegistro;
  String? fechaProgramado;
  Organizacion? organizacion;
  Responsable? responsable;
  Grupo? grupo;
  Area? area;
  Sector? sector;
  @ignore
  List<Detalle>? detalles;
  @ignore
  List<PuntoFijo>? puntosFijos;
  List<CategoriaElement>? categorias;
  Configuracion? configuracion;

  factory Auditoria.fromJson(Map<String, dynamic> json) => Auditoria(
        auditoriaId: json['auditoriaId'],
        codigo: json['codigo'],
        nombre: json['nombre'],
        estado: json['estado'],
        responsableId: json['responsableId'],
        auditorId: json['auditorId'],
        s1: json['s1'] ?? false,
        s2: json['s2'] ?? false,
        s3: json['s3'] ?? false,
        s4: json['s4'] ?? false,
        s5: json['s5'] ?? false,
        fechaRegistro: json['fechaRegistro'],
        fechaProgramado: json['fechaProgramado'],
        organizacion: Organizacion.fromJson(json['organizacion']),
        responsable: Responsable.fromJson(json['responsable']),
        grupo: Grupo.fromJson(json['grupo']),
        area: Area.fromJson(json['area']),
        sector: Sector.fromJson(json['sector']),
        detalles: json['detalles'] != null
            ? List<Detalle>.from(
                json['detalles'].map((x) => Detalle.fromJson(x)))
            : [],
        puntosFijos: json['puntosFijos'] != null
            ? List<PuntoFijo>.from(
                json['puntosFijos'].map((x) => PuntoFijo.fromJson(x)))
            : [],
        categorias: json['categorias'] != null
            ? List<CategoriaElement>.from(
                json['categorias'].map((x) => CategoriaElement.fromJson(x)))
            : [],
        configuracion: json['configuracion'] != null
            ? Configuracion.fromJson(json['configuracion'])
            : Configuracion(),
      );

  Map<String, dynamic> toJson() => {
        'auditoriaId': auditoriaId,
        'codigo': codigo,
        'nombre': nombre,
        'estado': estado,
        'responsableId': responsableId,
        'auditorId': auditorId,
        's1': s1,
        's2': s2,
        's3': s3,
        's4': s4,
        's5': s5,
        'fechaRegistro': fechaRegistro,
        'fechaProgramado': fechaProgramado,
        'responsable': responsable?.toJson(),
        'organizacion': organizacion?.toJson(),
        'grupo': grupo?.toJson(),
        'area': area?.toJson(),
        'sector': sector?.toJson(),
        'detalles': List<dynamic>.from(detalles!.map((x) => x.toJson())),
        'puntosFijos': List<dynamic>.from(puntosFijos!.map((x) => x.toJson())),
        'categorias': List<dynamic>.from(categorias!.map((x) => x.toJson())),
        'configuracion': configuracion?.toJson(),
      };

  Map<String, dynamic> toJsonOffline() => {
        'auditoriaId': auditoriaId,
        'codigo': codigo,
        'nombre': nombre,
        'estado': estado,
        'responsableId': responsableId,
        'organizacionId': organizacion?.organizacionId,
        'areaId': area?.areaId,
        'sectorId': sector?.sectorId,
        'auditorId': auditorId,
        's1': s1,
        's2': s2,
        's3': s3,
        's4': s4,
        's5': s5,
        'fechaRegistro': fechaRegistro,
        'fechaProgramado': fechaProgramado,
        'detalles': List<dynamic>.from(detalles!.map((x) => x.toJsonOffline())),
        'puntosFijos': List<dynamic>.from(puntosFijos!.map((x) => x.toJson())),
        'valorNegativo': false
      };

  Map<String, String> toDataJson() => {'model': jsonEncode(toJson())};
  Map<String, String> toDataJsonOffline() =>
      {'model': jsonEncode(toJsonOffline())};
}

class Organizacion {
  Organizacion({
    this.organizacionId,
    this.nombre,
  });

  int? organizacionId;
  String? nombre;

  factory Organizacion.fromJson(Map<String, dynamic> json) => Organizacion(
        organizacionId: json['organizacionId'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'organizacionId': organizacionId,
        'nombre': nombre,
      };
}

class Area {
  Area({
    this.areaId,
    this.nombre,
  });

  int? areaId;
  String? nombre;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        areaId: json['areaId'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'areaId': areaId,
        'nombre': nombre,
      };
}

class CategoriaElement {
  CategoriaElement({
    this.categoriaId,
    this.nombre,
    this.componentes = const [],
  });

  int? categoriaId;
  String? nombre;
  List<ComponenteElement> componentes;

  factory CategoriaElement.fromJson(Map<String, dynamic> json) =>
      CategoriaElement(
        categoriaId: json['categoriaId'],
        nombre: json['nombre'],
        componentes: List<ComponenteElement>.from(
            json['componentes'].map((x) => ComponenteElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'categoriaId': categoriaId,
        'nombre': nombre,
        'componentes': List<dynamic>.from(componentes.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return nombre ?? '';
  }
}

class ComponenteElement {
  ComponenteElement({
    this.categoriaId,
    this.componenteId,
    this.nombre,
  });

  int? categoriaId;
  int? componenteId;
  String? nombre;

  factory ComponenteElement.fromJson(Map<String, dynamic> json) =>
      ComponenteElement(
        categoriaId: json['categoriaId'],
        componenteId: json['componenteId'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'categoriaId': categoriaId,
        'componenteId': componenteId,
        'nombre': nombre,
      };

  @override
  String toString() {
    return nombre ?? '';
  }
}

class Configuracion {
  Configuracion({
    this.valorS1 = 0,
    this.valorS2 = 0,
    this.valorS3 = 0,
    this.valorS4 = 0,
    this.valorS5 = 0,
  });

  int? valorS1;
  int? valorS2;
  int? valorS3;
  int? valorS4;
  int? valorS5;

  factory Configuracion.fromJson(Map<String, dynamic> json) => Configuracion(
        valorS1: json['valorS1'],
        valorS2: json['valorS2'],
        valorS3: json['valorS3'],
        valorS4: json['valorS4'],
        valorS5: json['valorS5'],
      );

  Map<String, dynamic> toJson() => {
        'valorS1': valorS1,
        'valorS2': valorS2,
        'valorS3': valorS3,
        'valorS4': valorS4,
        'valorS5': valorS5,
      };
}

@TypeConverters([
  DetalleComponenteConvert,
  DetalleCategoriaConvert,
])
@entity
class Detalle {
  Detalle({
    this.id = 0,
    this.auditoriaDetalleId = 0,
    this.auditoriaId = 0,
    this.componenteId = 0,
    this.categoriaId = 0,
    this.componente,
    this.categoria,
    this.aspectoObservado = '',
    this.nombre = '',
    this.s1 = 0,
    this.s2 = 0,
    this.s3 = 0,
    this.s4 = 0,
    this.s5 = 0,
    this.detalle = '',
    this.fotoId = 0,
    this.url = '',
    this.path = '',
    this.pathPadre = '',
    this.eliminado = false,
    this.auditoriaDetallePadreId,
    this.auditoriaDetallePadreFotoId,
    this.finalizado = false,
  });
  @PrimaryKey(autoGenerate: true)
  int id;
  int auditoriaDetalleId;
  int auditoriaId;
  int componenteId;
  int categoriaId;
  DetalleComponente? componente;
  DetalleCategoria? categoria;
  String? aspectoObservado;
  String? nombre;
  int s1;
  int s2;
  int s3;
  int s4;
  int s5;
  String? detalle;
  int? fotoId;
  String url;
  String path;
  String pathPadre;
  bool eliminado;
  int? auditoriaDetallePadreId;
  int? auditoriaDetallePadreFotoId;
  bool finalizado;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        id: json['id'] ?? 0,
        auditoriaDetalleId: json['auditoriaDetalleId'],
        auditoriaId: json['auditoriaId'],
        componenteId: json['componenteId'],
        categoriaId: json['categoriaId'],
        componente: DetalleComponente.fromJson(json['componente']),
        categoria: DetalleCategoria.fromJson(json['categoria']),
        aspectoObservado: json['aspectoObservado'],
        nombre: json['nombre'],
        s1: json['s1'] ?? 0,
        s2: json['s2'] ?? 0,
        s3: json['s3'] ?? 0,
        s4: json['s4'] ?? 0,
        s5: json['s5'] ?? 0,
        detalle: json['detalle'],
        fotoId: json['fotoId'],
        url: json['url'] ?? '',
        eliminado: json['eliminado'],
        auditoriaDetallePadreId: json['auditoriaDetallePadreId'],
        auditoriaDetallePadreFotoId: json['auditoriaDetallePadreFotoId'],
        finalizado: json['finalizado'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'auditoriaDetalleId': auditoriaDetalleId,
        'auditoriaId': auditoriaId,
        'componenteId': componenteId,
        'categoriaId': categoriaId,
        'componente': componente?.toJson(),
        'categoria': categoria?.toJson(),
        'aspectoObservado': aspectoObservado,
        'nombre': nombre,
        's1': s1,
        's2': s2,
        's3': s3,
        's4': s4,
        's5': s5,
        'detalle': detalle,
        'fotoId': fotoId,
        'url': url,
        'eliminado': eliminado,
        'auditoriaDetallePadreId': auditoriaDetallePadreId,
        'auditoriaDetallePadreFotoId': auditoriaDetallePadreFotoId,
        'finalizado': finalizado,
      };

  Map<String, dynamic> toJsonOffline() => {
        'id': id,
        'auditoriaDetalleId': auditoriaDetalleId,
        'auditoriaId': auditoriaId,
        'componenteId': componenteId,
        'categoriaId': categoriaId,
        'aspectoObservado': aspectoObservado,
        'nombre': nombre,
        's1': s1,
        's2': s2,
        's3': s3,
        's4': s4,
        's5': s5,
        'detalle': detalle,
        'fotoId': fotoId,
        'url': url,
        'eliminado': eliminado,
        'auditoriaDetallePadreId': auditoriaDetallePadreId,
        'auditoriaDetallePadreFotoId': auditoriaDetallePadreFotoId,
        'finalizado': finalizado,
      };
}

class DetalleCategoria {
  DetalleCategoria({
    this.categoriaId = 0,
    this.nombre = '',
  });

  int? categoriaId;
  String? nombre;

  factory DetalleCategoria.fromJson(Map<String, dynamic> json) =>
      DetalleCategoria(
        categoriaId: json['categoriaId'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'categoriaId': categoriaId,
        'nombre': nombre,
      };
}

class DetalleComponente {
  DetalleComponente({
    this.componenteId = 0,
    this.nombre = '',
  });

  int? componenteId;
  String? nombre;

  factory DetalleComponente.fromJson(Map<String, dynamic> json) =>
      DetalleComponente(
        componenteId: json['componenteId'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'componenteId': componenteId,
        'nombre': nombre,
      };
}

class Grupo {
  Grupo({
    this.grupoId,
    this.nombre,
  });

  int? grupoId;
  String? nombre;

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        grupoId: json['grupoId'],
        nombre: json['nombre'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'grupoId': grupoId,
        'nombre': nombre,
      };
}

@entity
class PuntoFijo {
  PuntoFijo({
    this.auditoriaPuntoFijoId = 0,
    this.puntoFijoId = 0,
    this.auditoriaId = 0,
    this.nPuntoFijo = '',
    this.fotoId = 0,
    this.url = '',
    this.path = '',
  });
  @PrimaryKey(autoGenerate: true)
  int? auditoriaPuntoFijoId;
  int? puntoFijoId;
  int? auditoriaId;
  String? nPuntoFijo;
  int? fotoId;
  String url;
  String path;

  factory PuntoFijo.fromJson(Map<String, dynamic> json) => PuntoFijo(
        auditoriaPuntoFijoId: json['auditoriaPuntoFijoId'],
        puntoFijoId: json['puntoFijoId'],
        auditoriaId: json['auditoriaId'],
        nPuntoFijo: json['nPuntoFijo'],
        fotoId: json['fotoId'] ?? 0,
        url: json['url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'auditoriaPuntoFijoId': auditoriaPuntoFijoId,
        'puntoFijoId': puntoFijoId,
        'auditoriaId': auditoriaId,
        'nPuntoFijo': nPuntoFijo,
        'fotoId': fotoId,
        'url': url,
      };
}

class Responsable {
  Responsable({
    this.responsableId,
    this.nombreCompleto,
  });

  int? responsableId;
  String? nombreCompleto;

  factory Responsable.fromJson(Map<String, dynamic> json) => Responsable(
        responsableId: json['responsableId'],
        nombreCompleto: json['nombreCompleto'],
      );

  Map<String, dynamic> toJson() => {
        'rsponsableId': responsableId,
        'nombreCompleto': nombreCompleto,
      };
}

class Sector {
  Sector({
    this.sectorId,
    this.nombre,
  });

  int? sectorId;
  String? nombre;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        sectorId: json['sectorId'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'sectorId': sectorId,
        'nombre': nombre,
      };
}

AuditoriaHeaderResponse auditoriaHeaderResponseFromJson(String str) =>
    AuditoriaHeaderResponse.fromJson(json.decode(str));

String auditoriaHeaderResponseToJson(AuditoriaHeaderResponse data) =>
    json.encode(data.toJson());

class AuditoriaHeaderResponse {
  AuditoriaHeaderResponse({
    required this.auditoriaId,
    required this.estadoAuditoria,
  });

  int auditoriaId;
  int estadoAuditoria;

  factory AuditoriaHeaderResponse.fromJson(Map<String, dynamic> json) =>
      AuditoriaHeaderResponse(
        auditoriaId: json['auditoriaId'],
        estadoAuditoria: json['estadoAuditoria'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'auditoriaId': auditoriaId,
        'estadoAuditoria': estadoAuditoria,
      };
}

class ConfiguracionCombo {
  ConfiguracionCombo({
    this.id = 0,
    this.valor = '',
  });

  int id = 0;
  String valor = '';

  factory ConfiguracionCombo.fromJson(Map<String, dynamic> json) =>
      ConfiguracionCombo(
        id: json['id'],
        valor: json['valor'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'valor': valor,
      };

  @override
  String toString() {
    return '${getValor(id)} ($id)';
  }

  String getValor(int id) {
    var valor = '';
    switch (id) {
      case -20:
        valor = 'SSOMA';
        break;
      case -15:
        valor = 'Calidad';
        break;
      case -10:
        valor = 'Oper.';
        break;
      case -5:
        valor = 'No Oper';
        break;
      default:
        valor = 'Destacable';
        break;
    }

    return valor;
  }
}

// To parse this JSON data, do
//
//     final auditoriaOffLine = auditoriaOffLineFromJson(jsonString);

AuditoriaOffLine auditoriaOffLineFromJson(String str) =>
    AuditoriaOffLine.fromJson(json.decode(str));

String auditoriaOffLineToJson(AuditoriaOffLine data) =>
    json.encode(data.toJson());

@entity
class AuditoriaOffLine {
  AuditoriaOffLine({
    required this.auditoriaId,
    required this.estado,
  });
  @primaryKey
  int auditoriaId;
  int estado;

  factory AuditoriaOffLine.fromJson(Map<String, dynamic> json) =>
      AuditoriaOffLine(
        auditoriaId: json['auditoriaId'],
        estado: json['estado'],
      );

  Map<String, dynamic> toJson() => {
        'auditoriaId': auditoriaId,
        'estado': estado,
      };
}
