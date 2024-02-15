package com.example.method_channels_sample

import android.app.AlertDialog
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel




class MainActivity: FlutterActivity() {
    private val CHANNEL = "sample/popUp"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
          call, result ->
          if (call.method == "popUp") {
              this.context
            DialogClass().openDialog(this.context)
              result.success(null)
          } else {
            result.notImplemented()
          }
  

        }
      }
}

class DialogClass  {
    //open dialog
      fun openDialog(context: Context) {
        val builder: AlertDialog.Builder = AlertDialog.Builder(context)
        builder
            .setMessage("I am the message")
            .setTitle("I am the title")

        val dialog: AlertDialog = builder.create()
        dialog.show()

    }
}
