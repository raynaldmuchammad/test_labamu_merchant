class ThrowException implements Exception {
  final dynamic message;
  final dynamic prefix;

  ThrowException({this.message, this.prefix});

  String toString() {
    return "$prefix, $message";
  }
}

class FetchDataException extends ThrowException {
  FetchDataException([String? message])
      : super(message: "$message Error During Communication ");
}

class BadRequestException extends ThrowException {
  BadRequestException([String? message])
      : super(message: "$message Invalid request ");
}

class UnauthorizedException extends ThrowException {
  UnauthorizedException([String? message])
      : super(message: "$message Unauthorized");
}

class ExpiredTokenException extends ThrowException {
  ExpiredTokenException([int? statusCode])
      : super(message: "$statusCode Expired Token");
}

class InvalidInputException extends ThrowException {
  InvalidInputException([String? message])
      : super(message: "$message Invalid input");
}

class RequestTimeoutException extends ThrowException {
  RequestTimeoutException([String? message])
      : super(message: "$message Gateway Timeout");
}
