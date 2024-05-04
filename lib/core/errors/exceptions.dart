class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class EmailAlreadyInUseException implements Exception {
  final String message;

  EmailAlreadyInUseException([this.message = 'Email already in use']);
}

class WeakPasswordException implements Exception {
  final String message;

  WeakPasswordException([this.message = 'Weak password']);
}