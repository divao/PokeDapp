import 'package:domain/exceptions.dart';

enum GenericErrorType { unexpected, noConnection }

abstract class GenericError {
  final GenericErrorType type = GenericErrorType.unexpected;
}

GenericErrorType mapToGenericErrorType(dynamic object) {
  if (object is NoConnectionException) {
    return GenericErrorType.noConnection;
  }

  return GenericErrorType.unexpected;
}
