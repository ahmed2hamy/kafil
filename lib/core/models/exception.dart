
class ServerException implements Exception {
  final String? message;

  const ServerException(this.message);

  @override
  String toString() {
    Object? message = this.message;
    return "ServerException: $message";
  }
}

class CacheException implements Exception {
  final String? message;

  const CacheException(this.message);

  @override
  String toString() {
    Object? message = this.message;
    return "CacheException: $message";
  }
}