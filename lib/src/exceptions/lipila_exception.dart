/// Base exception for all Lipila SDK errors
sealed class LipilaException implements Exception {
  /// Creates a new Lipila exception
  const LipilaException(this.message, [this.statusCode, this.errors]);

  /// Error message
  final String message;

  /// HTTP status code (if applicable)
  final int? statusCode;
  final Map<String,dynamic>? errors;

  @override
  String toString() =>
      'LipilaException: $message${statusCode != null ? ' (Status: $statusCode) (Errors:$errors)' : ''}';
}

/// Exception for API-related errors
class ApiException extends LipilaException {
  /// Creates a new API exception
  const ApiException(super.message, [super.statusCode, super.errors]);

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode) (Errors:$errors)' : ''}';
}

/// Exception for authentication errors
class AuthException extends LipilaException {
  /// Creates a new authentication exception
  const AuthException(String message) : super(message, 401);

  @override
  String toString() => 'AuthException: $message';
}

/// Exception for validation errors
class ValidationException extends LipilaException {
  /// Creates a new validation exception
  const ValidationException(super.message, this.errors);

  /// Field-specific validation errors
  final Map<String, String> errors;

  @override
  String toString() => 'ValidationException: $message - Errors: $errors';
}

/// Exception for network-related errors
class NetworkException extends LipilaException {
  /// Creates a new network exception
  const NetworkException(String message) : super(message);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception for timeout errors
class TimeoutException extends LipilaException {
  /// Creates a new timeout exception
  const TimeoutException(String message) : super(message);

  @override
  String toString() => 'TimeoutException: $message';
}
