import 'dart:convert';

import 'package:app_fivesys/domain/models/offline.dart';
import 'package:floor/floor.dart';

import 'auditoria.dart';

class ListIntConverter extends TypeConverter<List<int>, String> {
  @override
  List<int> decode(String databaseValue) {
    return List<int>.from(
        json.decode(databaseValue).map((x) => x) as Iterable<dynamic>);
  }

  @override
  String encode(List<int> value) {
    return json.encode(List<int>.from(value.map((x) => x)));
  }
}

class ListStringConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    return List<String>.from(
        json.decode(databaseValue).map((x) => x) as Iterable<dynamic>);
  }

  @override
  String encode(List<String> value) {
    return json.encode(List<String>.from(value.map((x) => x)));
  }
}

class SectorConverter extends TypeConverter<Sector?, String> {
  @override
  Sector? decode(String databaseValue) {
    return Sector?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Sector? value) {
    return json.encode(value?.toJson());
  }
}

class OrganizacionConverter extends TypeConverter<Organizacion?, String> {
  @override
  Organizacion? decode(String databaseValue) {
    return Organizacion?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Organizacion? value) {
    return json.encode(value?.toJson());
  }
}

class AreaConverter extends TypeConverter<Area?, String> {
  @override
  Area? decode(String databaseValue) {
    return Area?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Area? value) {
    return json.encode(value?.toJson());
  }
}

class GrupoConverter extends TypeConverter<Grupo?, String> {
  @override
  Grupo? decode(String databaseValue) {
    return Grupo?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Grupo? value) {
    return json.encode(value?.toJson());
  }
}

class ResponsableConverter extends TypeConverter<Responsable?, String> {
  @override
  Responsable? decode(String databaseValue) {
    return Responsable?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Responsable? value) {
    return json.encode(value?.toJson());
  }
}

class ListDetalleConverter extends TypeConverter<List<Detalle>?, String> {
  @override
  List<Detalle> decode(String databaseValue) {
    return List<Detalle>.from(
        json.decode(databaseValue).map((x) => x) as Iterable<dynamic>);
  }

  @override
  String encode(List<Detalle>? value) {
    return value != null
        ? json.encode(List<Detalle>.from(value.map((x) => x)))
        : "";
  }
}

class ListPuntosFijoConverter extends TypeConverter<List<PuntoFijo>?, String> {
  @override
  List<PuntoFijo> decode(String databaseValue) {
    return List<PuntoFijo>.from(
        json.decode(databaseValue).map((x) => PuntoFijo.fromJson(x)));
  }

  @override
  String encode(List<PuntoFijo>? value) {
    return value != null
        ? json.encode(List<dynamic>.from(value.map((x) => x.toJson())))
        : "";
  }
}

class ListCategoriaElementConverter
    extends TypeConverter<List<CategoriaElement>?, String> {
  @override
  List<CategoriaElement> decode(String databaseValue) {
    return List<CategoriaElement>.from(
        json.decode(databaseValue).map((x) => CategoriaElement.fromJson(x)));
  }

  @override
  String encode(List<CategoriaElement>? value) {
    return value != null
        ? json.encode(List<dynamic>.from(value.map((x) => x.toJson())))
        : "";
  }
}

class ConfiguracionConverter extends TypeConverter<Configuracion?, String> {
  @override
  Configuracion? decode(String databaseValue) {
    return Configuracion?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Configuracion? value) {
    return json.encode(value?.toJson());
  }
}

class DetalleComponenteConvert
    extends TypeConverter<DetalleComponente?, String> {
  @override
  DetalleComponente? decode(String databaseValue) {
    return DetalleComponente?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(DetalleComponente? value) {
    return json.encode(value?.toJson());
  }
}

class DetalleCategoriaConvert extends TypeConverter<DetalleCategoria?, String> {
  @override
  DetalleCategoria? decode(String databaseValue) {
    return DetalleCategoria?.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(DetalleCategoria? value) {
    return json.encode(value?.toJson());
  }
}

// Offline
class AreaFiltroConverter extends TypeConverter<List<AreaFiltro>?, String> {
  @override
  List<AreaFiltro> decode(String databaseValue) {
    return List<AreaFiltro>.from(
        json.decode(databaseValue).map((x) => AreaFiltro.fromJson(x)));
  }

  @override
  String encode(List<AreaFiltro>? value) {
    return value != null
        ? json.encode(List<dynamic>.from(value.map((x) => x.toJson())))
        : "";
  }
}
/* 
class SectorFiltroConverter extends TypeConverter<List<SectorFiltro>?, String> {
  @override
  List<SectorFiltro> decode(String databaseValue) {
    return List<SectorFiltro>.from(
        json.decode(databaseValue).map((x) => SectorFiltro.fromJson(x)));
  }

  @override
  String encode(List<SectorFiltro>? value) {
    return value != null
        ? json.encode(List<dynamic>.from(value.map((x) => x.toJson())))
        : "";
  }
} */

class ComponenteFiltroConverter
    extends TypeConverter<List<ComponenteFiltro>?, String> {
  @override
  List<ComponenteFiltro> decode(String databaseValue) {
    return List<ComponenteFiltro>.from(
        json.decode(databaseValue).map((x) => ComponenteFiltro.fromJson(x)));
  }

  @override
  String encode(List<ComponenteFiltro>? value) {
    return value != null
        ? json.encode(List<dynamic>.from(value.map((x) => x.toJson())))
        : "";
  }
}
