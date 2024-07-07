enum RegionEventType {
  enter,
  exit,
  unknown;

  static RegionEventType fromString(String value) =>
    RegionEventType.values.firstWhere(
      (e) => e.toString() == 'RegionEventType.$value' || e.toString() == value,
      orElse: () => RegionEventType.unknown,
    );
}
