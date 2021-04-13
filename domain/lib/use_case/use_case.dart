import 'package:domain/exceptions.dart';
import 'package:domain/logger.dart';
import 'package:meta/meta.dart';

abstract class UseCase<P, R> {
  const UseCase({
    @required this.logger,
    this.shouldLogError = true,
  }) : assert(logger != null);

  final ErrorLogger logger;
  final bool shouldLogError;

  @protected
  Future<R> getRawFuture({P params});

  Future<R> getFuture({P params}) =>
      getRawFuture(params: params).catchError((error) async {
        if (shouldLogError ?? false) {
          await logger(error);
        }
        throw error;
      }).catchError((error) {
        if (error is! PokeDappException) {
          throw UnexpectedException();
        } else {
          throw error;
        }
      });
}
