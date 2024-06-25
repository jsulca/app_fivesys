import 'dart:io';

import 'package:flutter/services.dart';

class MediaStore {
  static const _channel = MethodChannel('flutter_media_store');

  Future<void> addItem({required File file, required String name}) async {
    await _channel.invokeMethod('addItem', {'path': file.path, 'name': name});
  }

  Future<void> addPdf({required File file, required String name}) async {
    await _channel.invokeMethod('addPdf', {'path': file.path, 'name': name});
  }

  Future<String> getItem({required String name}) async {
    return await _channel.invokeMethod('getItem', {'name': name});
  }

  Future<String> getPdf({required String name}) async {
    return await _channel.invokeMethod('getPdf', {'name': name});
  }

  Future<int> getVersionSdk() async {
    return await _channel.invokeMethod('getVersionSdk');
  }

  Future<void> deleteFolder() async {
    return await _channel.invokeMethod('deleteFolder');
  }
}
