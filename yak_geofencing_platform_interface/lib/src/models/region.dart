import 'package:meta/meta.dart';

@immutable
class Region {
  final String identifier;
  final double latitude;
  final double longitude;
  final double radius;
  final bool notifyOnEntry;
  final bool notifyOnExit;

  const Region({
    required this.identifier,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.notifyOnEntry = true,
    this.notifyOnExit = true,
  });

  static Region fromMap(dynamic message) {
    final Map<dynamic, dynamic> regionMap = message;

    if (!regionMap.containsKey('identifier')) {
      throw ArgumentError.value(regionMap, 'regionMap',
          'The supplied map doesn\'t contain the mandatory key `identifier`.');
    }

    if (!regionMap.containsKey('latitude')) {
      throw ArgumentError.value(regionMap, 'regionMap',
          'The supplied map doesn\'t contain the mandatory key `latitude`.');
    }

    if (!regionMap.containsKey('longitude')) {
      throw ArgumentError.value(regionMap, 'positionMap',
          'The supplied map doesn\'t contain the mandatory key `longitude`.');
    }

    if (!regionMap.containsKey('radius')) {
      throw ArgumentError.value(regionMap, 'regionMap',
          'The supplied map doesn\'t contain the mandatory key `radius`.');
    }

    return Region(
      identifier: regionMap['identifier'],
      latitude: regionMap['latitude'],
      longitude: regionMap['longitude'],
      radius: regionMap['radius'],
      notifyOnEntry: regionMap['notifyOnEntry'] ?? true,
      notifyOnExit: regionMap['notifyOnExit'] ?? true,
    );
  }

  Map<String, dynamic> toMap() => {
        'identifier': identifier,
        'longitude': longitude,
        'latitude': latitude,
        'radius': radius,
        'notifyOnEntry': notifyOnEntry,
        'notifyOnExit': notifyOnExit,
      };

  @override
  bool operator ==(Object other) {
    var areEqual = other is Region &&
        other.identifier == identifier &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.radius == radius &&
        other.notifyOnEntry == notifyOnEntry &&
        other.notifyOnExit == notifyOnExit;

    return areEqual;
  }

  @override
  int get hashCode =>
      identifier.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      radius.hashCode ^
      notifyOnEntry.hashCode ^
      notifyOnExit.hashCode;
}
