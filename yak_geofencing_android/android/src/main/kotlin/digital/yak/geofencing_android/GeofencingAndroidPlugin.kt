package digital.yak.geofencing_android

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GeofencingAndroidPlugin */
class GeofencingAndroidPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "geofencing_android")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "isRegionMonitoringAvailable") {
      onIsRegionMonitoringAvailable(call.arguments, result)
    } else if (call.method == "startMonitoringForRegion") {
      onStartMonitoringForRegion(call.arguments, result)
    }  else if (call.method == "stopMonitoringForRegion") {
      onStopMonitoringForRegion(call.arguments, result)
    } else if (call.method == "getMonitoredRegions") {
      onGetMonitoredRegions(call.arguments, result)
    } else if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  private fun onIsRegionMonitoringAvailable(arguments: Any, result: Result) {
    result.notImplemented()
  }

  private fun onStartMonitoringForRegion(arguments: Any, result: Result) {
    result.notImplemented()
  }

  private fun onStopMonitoringForRegion(arguments: Any, result: Result) {
    result.notImplemented()
  }

  private fun onGetMonitoredRegions(arguments: Any, result: Result) {
    result.notImplemented()
  }
}
