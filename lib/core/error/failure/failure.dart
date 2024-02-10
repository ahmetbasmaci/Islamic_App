abstract class Failure {
  final String message;
  Failure(this.message);
}

class AudioFailure extends Failure {
  AudioFailure(super.message);
}

class JsonFailure extends Failure {
  JsonFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class SqliteFailure extends Failure {
  SqliteFailure(super.message);
}
