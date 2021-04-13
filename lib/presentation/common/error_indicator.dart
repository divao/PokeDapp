import 'package:flutter/material.dart';
import 'package:poke_dapp/generated/l10n.dart';
import 'package:poke_dapp/presentation/common/adaptive_filled_button.dart';
import 'package:poke_dapp/presentation/common/generic_error.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    Key key,
    this.title,
    this.message,
    this.onActionButtonPressed,
    this.actionButtonText,
    this.genericErrorType = GenericErrorType.unexpected,
  }) : super(key: key);

  final String title;
  final String message;
  final String actionButtonText;
  final VoidCallback onActionButtonPressed;
  final GenericErrorType genericErrorType;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title ?? S.of(context).genericErrorTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, color: Colors.black54),
          ),
          Text(
            message ??
                (genericErrorType == GenericErrorType.unexpected
                    ? S.of(context).genericErrorMessage
                    : S.of(context).noConnectionErrorMessage),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AdaptiveFilledButton(
              onPressed: onActionButtonPressed,
              child: Text(actionButtonText ??
                  S.of(context).genericErrorActionButtonTitle),
            ),
          )
        ],
      ),
    ),
  );
}
