abstract class AppExceptions implements Exception {
  final String message;
  AppExceptions(this.message);
}

class AudioException extends AppExceptions {
  AudioException(super.message);
}
