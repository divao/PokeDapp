import 'package:flutter/widgets.dart';
import 'package:poke_dapp/presentation/adaptive_progress_indicator.dart';
import 'package:poke_dapp/presentation/common/error_indicator.dart';
import 'package:poke_dapp/presentation/common/generic_error.dart';

/// Chooses between a [AdaptativeProgressIndicator], an [ErrorIndicator] or a
/// content widget by matching the snapshot's data with the provided generic
/// types.
class AsyncSnapshotResponseView<Loading, Error, Success>
    extends StatelessWidget {
  AsyncSnapshotResponseView({
    @required this.successWidgetBuilder,
    @required this.snapshot,
    this.onTryAgainTap,
    this.errorWidgetBuilder,
    this.loadingWidgetBuilder,
    Key key,
  })  : assert(successWidgetBuilder != null),
        assert(snapshot != null),
        assert(Loading != dynamic),
        assert(Error != dynamic),
        assert(Success != dynamic),
        super(key: key);

  final AsyncSnapshot snapshot;
  final GestureTapCallback onTryAgainTap;
  final Widget Function(BuildContext context, Error error) errorWidgetBuilder;
  final Widget Function(BuildContext context, Success success)
  successWidgetBuilder;
  final Widget Function(BuildContext context, Loading loading)
  loadingWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final snapshotData = snapshot.data;
    if (snapshotData == null || snapshotData is Loading) {
      if (loadingWidgetBuilder != null) {
        return loadingWidgetBuilder(context, snapshotData);
      }

      return AdaptativeProgressIndicator();
    }

    if (snapshotData is Error) {
      if (errorWidgetBuilder != null) {
        return errorWidgetBuilder(context, snapshotData);
      }

      var genericErrorType = GenericErrorType.unexpected;
      if (snapshotData is GenericError) {
        final GenericError genericError = snapshotData;
        genericErrorType = genericError.type;
      }

      return ErrorIndicator(
        onActionButtonPressed: onTryAgainTap,
        genericErrorType: genericErrorType,
      );
    }

    if (snapshotData is Success) {
      return successWidgetBuilder(context, snapshotData);
    }

    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}
