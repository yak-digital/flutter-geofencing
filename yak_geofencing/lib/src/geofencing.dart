import 'dart:async';

import 'package:yak_geofencing_platform_interface/yak_geofencing_platform_interface.dart';

class Geofencing {
  static Stream<RegionEvent> getMonitorStream() =>
      GeofencingPlatform.instance.getMonitorStream();

  static Future<bool> isRegionMonitoringAvailable() =>
      GeofencingPlatform.instance.isRegionMonitoringAvailable();

  static Future<void> startMonitoringForRegion(Region region) =>
      GeofencingPlatform.instance.startMonitoringForRegion(region);

  static Future<void> stopMonitoringForRegion(Region region) =>
      GeofencingPlatform.instance.stopMonitoringForRegion(region);

  static Future<List<Region>> getMonitoredRegions() =>
      GeofencingPlatform.instance.getMonitoredRegions();
}
