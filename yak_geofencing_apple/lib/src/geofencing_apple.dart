import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yak_geofencing_platform_interface/yak_geofencing_platform_interface.dart';

class GeofencingApple extends GeofencingPlatform {
  static const _methodChannel = MethodChannel('yak.digital/geofencing_apple');

  static const _monitorChannel =
      EventChannel('yak.digital/geofencing_monitor_apple');

  static void registerWith() {
    GeofencingPlatform.instance = GeofencingApple();
  }

  Stream<RegionEvent>? _monitorStream;

  @override
  Stream<RegionEvent> getMonitorStream() {
    if (_monitorStream != null) {
      return _monitorStream!;
    }
    var originalStream = _monitorChannel.receiveBroadcastStream();
    var monitorStream = _wrapStream(originalStream);

    _monitorStream = monitorStream.map<RegionEvent>((dynamic element) {
      return RegionEvent.fromMap(element);
    }).handleError(
      (error) {
        if (error is PlatformException) {
          error = _handlePlatformException(error);
        }
        throw error;
      },
    );
    return _monitorStream!;
  }

  @override
  Future<bool> isRegionMonitoringAvailable() async {
    return await _methodChannel.invokeMethod('isRegionMonitoringAvailable');
  }

  @override
  Future<void> startMonitoringForRegion(Region region) async {
    return await _methodChannel
        .invokeMethod('startMonitoringForRegion', <String, dynamic>{
      'region': region.toMap(),
    });
  }

  @override
  Future<void> stopMonitoringForRegion(Region region) async {
    return await _methodChannel
        .invokeMethod('stopMonitoringForRegion', <String, dynamic>{
      'region': region.toMap(),
    });
  }

  @override
  Future<List<Region>> getMonitoredRegions() async {
    final regions = await _methodChannel.invokeMethod('getMonitoredRegions');
    return regions.map<Region>((json) => Region.fromMap(json)).toList();
  }

  Stream<dynamic> _wrapStream(Stream<dynamic> incoming) {
    return incoming.asBroadcastStream(onCancel: (subscription) {
      subscription.cancel();
      _monitorStream = null;
    });
  }

  Exception _handlePlatformException(PlatformException exception) {
    switch (exception.code) {
      case 'EVENT_SUBSCRIPTION_ACTIVE':
        return const EventSubscriptionActiveException();
      default:
        return exception;
    }
  }
}