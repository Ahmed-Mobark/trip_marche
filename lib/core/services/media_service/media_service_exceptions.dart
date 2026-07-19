class PermissionException implements Exception {
  final String message;
  const PermissionException(this.message);
}

class CameraUnavailableException implements Exception {
  final String message;
  const CameraUnavailableException(this.message);
}

class InvalidFileException implements Exception {
  final String message;
  const InvalidFileException(this.message);
}

class FileTooLargeException implements Exception {
  final String message;
  const FileTooLargeException(this.message);
}
