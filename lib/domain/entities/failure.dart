class Failure {
  final String _message;

  Failure(this._message);

  get message => _message;

  @override
  String toString() {
    return _message;
  }
}
