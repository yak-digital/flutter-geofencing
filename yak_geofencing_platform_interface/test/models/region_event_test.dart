import 'package:flutter_test/flutter_test.dart';
import 'package:yak_geofencing_platform_interface/yak_geofencing_platform_interface.dart';

void main() {
  group('$RegionEvent', () {
    test('', () {
      final regionEvent = RegionEvent(
          const Region(
              identifier: 'test',
              latitude: 52.373920,
              longitude: 9.735603,
              radius: 100.0),
          RegionEventType.exit);
      final regionEventFromMap = RegionEvent.fromMap({
        "region": {
          "identifier": "test",
          "latitude": 52.373920,
          "longitude": 9.735603,
          "radius": 100.0,
        },
        "type": "exit",
      });

      expect(
        regionEvent,
        regionEventFromMap,
      );
    });
  });
}
