sealed class Result<S,E>{}

class Success<S,E> extends Result<S,E>{
  final S data;
  Success(this.data);
}

class Failure<S,E> extends Result<S,E>{
  final E error;
  Failure(this.error);
}