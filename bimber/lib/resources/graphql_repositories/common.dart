import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class GraphqlException implements Exception {
  String message;
  List<GraphQLError> errors;

  GraphqlException({@required this.message});

  String toString() {
    return "GraphqlException { message: $message }";
  }

  GraphqlException.fromGraphqlError(List<GraphQLError> errors)
      : message = "Wystąpił nieznany błąd!",
        errors = errors {}
}

class GraphqlConnectionError extends GraphqlException {
  GraphqlConnectionError() : super(message: "Brak połączenia z serwerem");
}

bool isConnectionException(LinkException exception) {
  if (exception == null) return false;
  if (exception.originalException is SocketException) return true;
  return false;
}

void checkQueryResultForErrors(QueryResult result) {
  if (result.hasException) {
    if (isConnectionException(result.exception.linkException)) {
      throw GraphqlConnectionError();
    }

    throw GraphqlException.fromGraphqlError(result.exception.graphqlErrors);
  }
}
