import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_fivesys/helpers/media_store.dart';
import 'package:app_fivesys/ui/widget/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

const kPrimaryColor = Color(0xFF2F4780);
const kPrimaryDarkColor = Color(0xFF303F9F);
const kPrimaryLightColor = Color(0xFFD9DDF2);
const kAccentColor = Color(0xFFBBDA34);

const kPendienteColor = Color(0xFFF2B701);
const kTerminadoColor = Color(0xFFBBDA34);
const kRedColor = Color(0xFFDB0030);
const kBlueGreyColor = Color(0xFF607D8B);
const kGreyColor = Color(0xFFC4C4C4);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
const kDarkColor = Color(0xFF383737);

const kDefaultPadding = 20.0;
const kDefaultTime = Duration(milliseconds: 750);

final kWhiteCustomColor = Colors.black.withOpacity(0.03);

final gradients = [
  kPrimaryColor,
  kPrimaryDarkColor,
];

Color colorConvert(String color) {
  final kColor = color.replaceAll("#", "");
  return Color(int.parse("0xFF$kColor"));
}

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: kPrimaryColor.withOpacity(0.1),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  canvasColor: kWhiteColor,
  iconTheme: const IconThemeData(
    color: kBlackColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: kAccentColor,
  ),
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColor,
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  // backgroundColor: kBlackColor,
  scaffoldBackgroundColor: kBlackColor,
  textTheme: const TextTheme(
    // subtitle1: TextStyle(color: kWhiteColor),
    // bodyText1: TextStyle(color: kWhiteColor),
  ),
  iconTheme: const IconThemeData(color: kWhiteColor),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: kWhiteColor,
    ),
  ),
  // bottomAppBarColor: Colors.transparent,
  canvasColor: kBlackColor,
  dialogBackgroundColor: kBlackColor,
  dialogTheme: const DialogTheme(titleTextStyle: TextStyle(color: kWhiteColor)),
  popupMenuTheme: const PopupMenuThemeData(
    color: kAccentColor,
    textStyle: TextStyle(color: kWhiteColor),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: kAccentColor,
  ),
  // toggleableActiveColor: kPrimaryColor,
);

String urlPhoto = 'https://free.auditoria5s.com/api/adjunto/buscar/?id=';

String getStringSizeLengthFile(int size) {
  final df = NumberFormat("0.00");
  const sizeKb = 1024;
  const sizeMb = sizeKb * sizeKb;
  const sizeGb = sizeMb * sizeKb;
  const sizeTerra = sizeGb * sizeKb;

  if (size < sizeMb) {
    return "${df.format(size / sizeKb.toDouble())} Kb";
  } else if (size < sizeGb) {
    return "${df.format(size / sizeMb.toDouble())} Mb";
  } else if (size < sizeTerra) {
    return "${df.format(size / sizeGb.toDouble())} Gb";
  } else {
    return '';
  }
}

String getFecha() {
  final now = DateTime.now();
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(now);
}

String getFechaFile(int user, String type) {
  final now = DateTime.now();
  final formatter = DateFormat('ddMMyyyy_HHmmssSSSS');
  final String formattedDate = formatter.format(now);
  return "${user}_$formattedDate$type";
}

Widget popuptitle(String title, {bool darkTheme = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style:
          TextStyle(fontSize: 25, color: darkTheme ? kWhiteColor : kBlackColor),
    ),
  );
}

InputDecoration getDropDownInPutDecoration({String label = ''}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelText: label);
}

InputDecoration getTextFieldInputDecoration(String title,
    {bool required = false, IconData? suffixIcon, bool darkTheme = false}) {
  return InputDecoration(
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    counter: (required == true)
        ? const Text(
            '(*)',
            style: TextStyle(color: Colors.red),
          )
        : null,
    labelText: title,
    suffixIcon: Icon(
      suffixIcon,
      color: darkTheme ? kWhiteColor : null,
      size: 25.0,
    ),
  );
}

String getDateTime(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

Decoration getThemeBoxDecoration(
    {bool darkTheme = false, double blurRadius = 6.0}) {
  return BoxDecoration(
    color: darkTheme ? kDarkColor : kWhiteColor,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: darkTheme ? kAccentColor : kDarkColor,
        offset: const Offset(0.0, 1.0), //(x,y)
        blurRadius: blurRadius,
      ),
    ],
  );
}

TransitionBuilder? builderPickerTheme({bool darkTheme = false}) {
  return (context, child) {
    return Theme(
      data: darkTheme ? ThemeData.dark() : ThemeData.light(),
      child: child!,
    );
  };
}

void dialogLoad(BuildContext context, String title, bool darkTheme) {
  final AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100.0))),
    content: Container(
      color: darkTheme ? kBlackColor : kWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(color: darkTheme ? kWhiteColor : kPrimaryColor),
          )
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Route navegarMapaFadeIn(BuildContext context, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut),
        ),
      );
    },
  );
}

Widget noImagen(Size size) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(kDefaultPadding),
      topRight: Radius.circular(kDefaultPadding),
    ),
    child: Image.asset(
      'assets/image/no_imagen.png',
      width: size.width,
      height: 180.0,
      fit: BoxFit.fill,
    ),
  );
}

Widget noImagenDetalle(Size size) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(
      Radius.circular(kDefaultPadding),
    ),
    child: Image.asset(
      'assets/image/no_imagen.png',
      width: size.width,
      height: 150.0,
      fit: BoxFit.fill,
    ),
  );
}

Future<String> createFileGallery(
    PlatformFile p, String fileName, String fileNewName) async {
  if (Platform.isAndroid) {
    final mediaStore = MediaStore();
    final sdk = await mediaStore.getVersionSdk();
    if (sdk >= 29) {
      final directory = await path_provider.getTemporaryDirectory();
      final filePath = path.join(directory.path, fileName);

      final xFile = File(p.path!);
      final data = await xFile.readAsBytes();

      final tempFile = await File(filePath).writeAsBytes(data);

      await mediaStore.addItem(file: tempFile, name: fileNewName);
      await tempFile.delete();
      return await mediaStore.getItem(name: fileNewName);
    }

    Directory directory = (await path_provider.getExternalStorageDirectory())!;
    String newPath = '';
    final List<String> paths = directory.path.split('/');
    for (int x = 1; x < paths.length; x++) {
      final folder = paths[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      } else {
        break;
      }
    }
    newPath = '$newPath/FiveSys';
    directory = Directory(newPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File(p.path!);
    final data = await file.readAsBytes();

    final newFile = File('$newPath/$fileNewName');
    await newFile.create(recursive: true);
    await newFile.writeAsBytes(data);

    return newFile.path;
  } else {
    final Directory documents =
        await path_provider.getApplicationDocumentsDirectory();
    if (!await documents.exists()) {
      await documents.create(recursive: true);
    }
    final file = File(p.path!);
    final data = await file.readAsBytes();

    final newFile = File('${documents.path}/$fileNewName');
    await newFile.create(recursive: true);
    await newFile.writeAsBytes(data);
    return newFile.path;
  }
}

Future<String> createFileCamera(
    XFile p, String fileName, String fileNewName) async {
  if (Platform.isAndroid) {
    final mediaStore = MediaStore();
    final sdk = await mediaStore.getVersionSdk();
    if (sdk >= 29) {
      final directory = await path_provider.getTemporaryDirectory();
      final filePath = path.join(directory.path, fileName);

      final xFile = File(p.path);
      final data = await xFile.readAsBytes();

      final tempFile = await File(filePath).writeAsBytes(data);

      await mediaStore.addItem(file: tempFile, name: fileNewName);
      await tempFile.delete();
      return await mediaStore.getItem(name: fileNewName);
    }

    Directory directory = (await path_provider.getExternalStorageDirectory())!;
    String newPath = '';
    final List<String> paths = directory.path.split('/');
    for (int x = 1; x < paths.length; x++) {
      final folder = paths[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      } else {
        break;
      }
    }
    newPath = '$newPath/FiveSys';
    directory = Directory(newPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File(p.path);
    final data = await file.readAsBytes();

    final newFile = File('$newPath/$fileNewName');
    await newFile.create(recursive: true);
    await newFile.writeAsBytes(data);

    return newFile.path;
  } else {
    final Directory documents =
        await path_provider.getApplicationDocumentsDirectory();
    if (!await documents.exists()) {
      await documents.create(recursive: true);
    }
    final file = File(p.path);
    final data = await file.readAsBytes();

    final newFile = File('${documents.path}/$fileNewName');
    await newFile.create(recursive: true);
    await newFile.writeAsBytes(data);
    return newFile.path;
  }
}

Future<String> savePdf(List<int> bytes, String fileNewName) async {
  if (Platform.isAndroid) {
    final mediaStore = MediaStore();
    final sdk = await mediaStore.getVersionSdk();
    if (sdk >= 29) {
      final directory = await path_provider.getTemporaryDirectory();
      final filePath = path.join(directory.path, fileNewName);

      final tempFile = await File(filePath).writeAsBytes(bytes);

      await mediaStore.addPdf(file: tempFile, name: fileNewName);
      await tempFile.delete();
      return await mediaStore.getPdf(name: fileNewName);
    }

    final directory = await getDownloadPath();
    final newFile = File('$directory/$fileNewName');
    await newFile.writeAsBytes(bytes);
    return newFile.path;
  } else {
    final directory = await getDownloadPath();
    final newFile = File('$directory/$fileNewName');
    await newFile.writeAsBytes(bytes);
    return newFile.path;
  }
}

Future<String> saveImage(List<int> bytes, String fileNewName) async {
  if (Platform.isAndroid) {
    final mediaStore = MediaStore();
    final sdk = await mediaStore.getVersionSdk();
    if (sdk >= 29) {
      final directory = await path_provider.getTemporaryDirectory();
      final filePath = path.join(directory.path, fileNewName);

      final tempFile = await File(filePath).writeAsBytes(bytes);

      await mediaStore.addItem(file: tempFile, name: fileNewName);
      await tempFile.delete();
      return await mediaStore.getItem(name: fileNewName);
    }

    Directory directory = (await path_provider.getExternalStorageDirectory())!;
    String newPath = '';
    final List<String> paths = directory.path.split('/');
    for (int x = 1; x < paths.length; x++) {
      final folder = paths[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      } else {
        break;
      }
    }
    newPath = '$newPath/FiveSys';
    directory = Directory(newPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final newFile = File('$newPath/$fileNewName');
    await newFile.create(recursive: true);
    await newFile.writeAsBytes(bytes);

    return newFile.path;
  } else {
    final Directory documents =
        await path_provider.getApplicationDocumentsDirectory();
    if (!await documents.exists()) {
      await documents.create(recursive: true);
    }

    final newFile = File('${documents.path}/$fileNewName');
    await newFile.create(recursive: true);
    await newFile.writeAsBytes(bytes);
    return newFile.path;
  }
}

Future<String?> getDownloadPath() async {
  Directory? directory;

  if (Platform.isIOS) {
    directory = await path_provider.getApplicationDocumentsDirectory();
  } else {
    directory = Directory('/storage/emulated/0/Download');
    // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
    // ignore: avoid_slow_async_io
    if (!await directory.exists()) {
      directory = await path_provider.getExternalStorageDirectory();
    }
  }

  return directory?.path;
}

void showSnackBar(String title, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomSnackBar(
        errorText: title,
      ),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

String getAuditoriaCodigoCorrelativo(int id) {
  const codigo = 'OFF-0000';
  final total = id.toString().length;
  return '${codigo.substring(0, codigo.length - total)}$id';
}

bool isEmail(String email) {
  const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (regExp.hasMatch(email)) {
    return true;
  }
  return false;
}

Future<bool> permission() async {
  if (Platform.isAndroid) {
    final mediaStore = MediaStore();
    final sdk = await mediaStore.getVersionSdk();
    if (sdk >= 33) {
      final storage = await Permission.photos.request();
      if (storage.isDenied) {
        logException('Aceptar permiso.');
        return false;
      }
    } else {
      final storage = await Permission.storage.request();
      if (storage.isDenied) {
        logException('Aceptar permiso.');
        return false;
      }
    }

    final accessMediaLocation = await Permission.accessMediaLocation.request();
    if (accessMediaLocation.isDenied) {
      logException('Aceptar permiso.');
      return false;
    }
    /*    final manageExternalStorage =
        await Permission.manageExternalStorage.request();
    if (manageExternalStorage.isDenied) {
      logException('Aceptar permiso.');
      return false;
    } */
  }
  if (Platform.isIOS) {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
    ].request();

    if (statuses[Permission.photos]!.isDenied) {
      logException('Aceptar permiso.');
      return false;
    }
  }
  return true;
}

Future<bool> permissionWrite() async {
  if (Platform.isAndroid) {
    final storage = await Permission.storage.request();
    if (storage.isDenied) {
      logException('Aceptar permiso.');
      return false;
    }
  }
  if (Platform.isIOS) {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
    ].request();

    if (statuses[Permission.photos]!.isDenied) {
      logException('Aceptar permiso.');
      return false;
    }
  }
  return true;
}

void logException(String message) {
  Get.snackbar(
    'Mensaje',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black,
    colorText: Colors.white,
  );
}

Future<void> deleteDirectoy() async {
  if (Platform.isAndroid) {
    final mediaStore = MediaStore();
    final sdk = await mediaStore.getVersionSdk();
    if (sdk >= 29) {
      await mediaStore.deleteFolder();
      return;
    }

    Directory directory = (await path_provider.getExternalStorageDirectory())!;
    String newPath = '';
    final List<String> paths = directory.path.split('/');
    for (int x = 1; x < paths.length; x++) {
      final folder = paths[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      } else {
        break;
      }
    }
    newPath = '$newPath/FiveSys';
    directory = Directory(newPath);
    if (await directory.exists()) {
      directory.deleteSync(recursive: true);
      //directory.list().asyncMap((event) => event.delete());
    }
    return;
  } else {
    /* final Directory documents =
        await path_provider.getApplicationDocumentsDirectory();
    if (!await documents.exists()) {
      await documents.create(recursive: true);
    } */
  }
}
