bool isDataStale(
  int ttlInSeconds,
  int createdAt,
  int? updatedAt,
) {
  final currentTime = DateTime.now(); // Current time in seconds
  final savedTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
  final Duration ageOfData = currentTime.difference(savedTime);
  return ageOfData.inSeconds > ttlInSeconds;
}
