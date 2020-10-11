import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class GraphqlException implements Exception {
  String message;

  GraphqlException({@required this.message});

  String toString() {
    return "GraphqlException { message: $message }";
  }

  GraphqlException.fromGraphqlError(OperationException exception)
      : message = "Wystąpił nieznany błąd!" {
    print(exception);
  }
}

class GraphqlConnectionError extends GraphqlException {
  GraphqlConnectionError() : super(message: "Brak połączenia z serwerem");
}

void checkQueryResultForErrors(QueryResult result) {
  if (result.hasException) {
    if (result.exception.toString().contains("Failed to connect")) {
      throw GraphqlConnectionError();
    }
  }
}
