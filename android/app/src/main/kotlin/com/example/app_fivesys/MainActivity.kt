package com.example.app_fivesys

import android.view.WindowManager.LayoutParams
import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import android.webkit.MimeTypeMap
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "flutter_media_store"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "addItem" -> {
                    addItem(call.argument("path")!!, call.argument("name")!!)
                    result.success(null)
                }

                "addPdf" -> {
                    addPdf(call.argument("path")!!, call.argument("name")!!)
                    result.success(null)
                }

                "getItem" -> {
                    result.success(getItem(call.argument("name")!!))
                }

                "getPdf" -> {
                    result.success(getPdf(call.argument("name")!!))
                }

                "getVersionSdk" -> {
                    result.success(getVersionSdk())
                }

                "deleteFolder" -> {
                    deleteFolder()
                    result.success(null)
                }
            }
        }
    }

    private fun addItem(path: String, name: String) {
        val extension = MimeTypeMap.getFileExtensionFromUrl(path)
        val mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)!!

        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Images.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else {
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        }

        val values = ContentValues().apply {
            put(MediaStore.Images.Media.DISPLAY_NAME, name)
            put(MediaStore.Images.Media.MIME_TYPE, mimeType)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(
                    MediaStore.MediaColumns.RELATIVE_PATH,
                    Environment.DIRECTORY_PICTURES + File.separator + getString(R.string.app_name)
                )
                put(MediaStore.Images.Media.IS_PENDING, 1)
            }
        }

        val resolver = applicationContext.contentResolver
        val uri = resolver.insert(collection, values)!!

        try {
            resolver.openOutputStream(uri).use { os ->
                File(path).inputStream().use { it.copyTo(os!!) }
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                values.clear()
                values.put(MediaStore.Images.Media.IS_PENDING, 0)
                resolver.update(uri, values, null, null)
            }
        } catch (ex: IOException) {
            Log.e("MediaStore", ex.message, ex)
        }
    }

    private fun addPdf(path: String, name: String) {
        val extension = MimeTypeMap.getFileExtensionFromUrl(path)
        val mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)!!

        val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            MediaStore.Files.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        } else {
            MediaStore.Files.getContentUri(MediaStore.VOLUME_EXTERNAL)
        }

        val values = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, name)
            put(MediaStore.MediaColumns.MIME_TYPE, mimeType)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
                put(MediaStore.Video.Media.IS_PENDING, 1)
            }
        }

        val resolver = applicationContext.contentResolver
        val uri = resolver.insert(collection, values)!!

        try {
            resolver.openOutputStream(uri).use { os ->
                File(path).inputStream().use { it.copyTo(os!!) }
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                values.clear()
                values.put(MediaStore.Video.Media.IS_PENDING, 0)
                resolver.update(uri, values, null, null)
            }
        } catch (ex: IOException) {
            Log.e("MediaStore", ex.message, ex)
        }
    }

    private fun getItem(name: String): String {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            File(
                Environment.getExternalStorageDirectory(),
                Environment.DIRECTORY_PICTURES + File.separator + getString(R.string.app_name) + File.separator + name
            ).absolutePath
        } else {
            File(
                Environment.getExternalStorageDirectory(),
                Environment.DIRECTORY_PICTURES + File.separator + name
            ).absolutePath
        }
    }

    private fun getPdf(name: String): String {
        return File(
            Environment.getExternalStorageDirectory(),
            Environment.DIRECTORY_DOWNLOADS + File.separator + name
        ).absolutePath
    }

    private fun getVersionSdk(): Int {
        return Build.VERSION.SDK_INT
    }

    private fun deleteFolder() {
        val folder = File(
            Environment.getExternalStorageDirectory(),
            Environment.DIRECTORY_PICTURES + File.separator + getString(R.string.app_name)
        )
        val list: Array<out File> = folder.listFiles() ?: return
        for (items in list) {
            items.delete()
        }
    }
}
