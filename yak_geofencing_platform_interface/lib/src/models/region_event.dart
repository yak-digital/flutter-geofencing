import '../enums/event_type.dart';

import 'region.dart';

class RegionEvent {
  final Region region;
  final RegionEventType type;

  RegionEvent(this.region, this.type);

  static RegionEvent fromMap(dynamic message) {
    final Map<dynamic, dynamic> regionEventMap = message;

    if (!regionEventMap.containsKey('region')) {
      throw ArgumentError.value(regionEventMap, 'regionEventMap',
          'The supplied map doesn\'t contain the mandatory key `region`.');
    }

    if (!regionEventMap.containsKey('type')) {
      throw ArgumentError.value(regionEventMap, 'regionEventMap',
          'The supplied map doesn\'t contain the mandatory key `type`.');
    }

    return RegionEvent(
      Region.fromMap(regionEventMap['region']),
      RegionEventType.fromString(regionEventMap['type']),
    );
  }

  @override
  bool operator ==(Object other) {
    var areEqual =
        other is RegionEvent && other.region == region && other.type == type;

    return areEqual;
  }

  @override
  int get hashCode => region.hashCode ^ type.hashCode;
}
