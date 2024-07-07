class EventSubscriptionActiveException implements Exception {
  const EventSubscriptionActiveException();

  @override
  String toString() =>
      'Already listening for geofencing events. It is not possible to listen to'
      'more then one stream at the same time.';
}
