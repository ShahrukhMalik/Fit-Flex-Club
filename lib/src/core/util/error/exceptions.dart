/// this is custom class for server exception
class ServerException implements Exception {
  final String errorMessage;
  final String? errorCode;

  ServerException({required this.errorMessage, this.errorCode});
}

/// this is custom class for cache exception
class CacheException implements Exception {
  final String errorMessage;
  final String? errorCode;

  CacheException({required this.errorMessage, this.errorCode});
}
