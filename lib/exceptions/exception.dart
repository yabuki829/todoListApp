class APIException implements Exception {
  final String message;
  final int? statusCode;

  APIException(this.message, [this.statusCode]);

  APIException.badRequest() : this('Bad Request', 400);
  APIException.unauthorized() : this('Unauthorized', 401);
  APIException.forbidden() : this('Forbidden', 403);
  APIException.notFound() : this('Not Found', 404);
  APIException.methodNotAllowed() : this('Method Not Allowed', 405);
  APIException.notAcceptable() : this('Not Acceptable', 406);
  APIException.proxyAuthenticationRequired()
      : this('Proxy Authentication Required', 407);
  APIException.requestTimeout() : this('Request Timeout', 408);
  APIException.conflict() : this('Conflict', 409);
  APIException.gone() : this('Gone', 410);

  APIException.unprocessableEntity() : this('Unprocessable Entity', 422);

  APIException.internalServerError() : this('Internal Server Error', 500);

  APIException.badGateway() : this('Bad Gateway', 502);

  APIException.serviceUnavailable() : this('Service Unavailable', 503);

  APIException.gatewayTimeout() : this('Gateway Timeout', 504);

  @override
  String toString() => 'APIException: $message (Status code: $statusCode)';

  String getMessage() => message;
}
