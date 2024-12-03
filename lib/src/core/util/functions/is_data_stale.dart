bool isDataStale(
  int ttlInSeconds,
  int createdAt,
  int? updatedAt,
) {
  final currentTime =
      DateTime.now().millisecondsSinceEpoch; // Current time in seconds
  final ageOfDataInSeconds = (currentTime -
      ((updatedAt != null && updatedAt > 0) ? updatedAt : createdAt)) ~/ 1000;
  return ageOfDataInSeconds > ttlInSeconds;
}
