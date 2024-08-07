import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'implementations/method_channel_geofencing.dart';
import 'models/region.dart';
import 'models/geofencing_event.dart';

typedef RegionChangedHandler = void Function(Region region);

abstract class GeofencingPlatform extends PlatformInterface {
  GeofencingPlatform() : super(token: _token);

  static final Object _token = Object();

  static GeofencingPlatform _instance = MethodChannelGeofencing();

  static GeofencingPlatform get instance => _instance;

  static set instance(GeofencingPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Stream<GeofencingEvent> getMonitorStream() {
    throw UnimplementedError(
      'getMonitorStream() has not been implemented.',
    );
  }

  Future<bool> isRegionMonitoringAvailable() async {
    throw UnimplementedError(
      'isRegionMonitoringAvailable() has not been implemented.',
    );
  }

  Future<void> startMonitoringForRegion(Region region) async {
    throw UnimplementedError(
      'startMonitoringForRegion() has not been implemented.',
    );
  }

  Future<void> stopMonitoringForRegion(Region region) async {
    throw UnimplementedError(
      'stopMonitoringForRegion() has not been implemented.',
    );
  }

  Future<List<Region>> getMonitoredRegions() async {
    throw UnimplementedError(
      'getMonitoredRegions() has not been implemented.',
    );
  }

  /*
  static RegionChangedHandler? _onEnterRegionHandler;
  static RegionChangedHandler? _onExitRegionHandler;

  static RegionChangedHandler? get onEnterRegion => _onEnterRegionHandler;

  static set onEnterRegion(RegionChangedHandler? handler) {
    _onEnterRegionHandler = handler;
  }

  static RegionChangedHandler? get onExitRegion => _onExitRegionHandler;

  static set onExitRegion(RegionChangedHandler? handler) {
    _onExitRegionHandler = handler;
  }*/
}
