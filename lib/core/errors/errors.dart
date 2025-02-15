abstract class Errors {
  String massage;
  Errors({required this.massage});
}

class RemoteError extends Errors {
  RemoteError({required super.massage});
}
class LocalError extends Errors {
  LocalError({required super.massage});
}