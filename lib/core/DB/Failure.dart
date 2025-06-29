abstract class Failure {
  final String message;
  Failure(this.message);
}

class DBFailure extends Failure {
  DBFailure(super.message);
}