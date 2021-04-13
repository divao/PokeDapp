import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/presentation/common/adaptive_stateless_widget.dart';

/// Filled button that renders differently depending on the platform
/// we're running on.
class AdaptiveFilledButton extends AdaptiveStatelessWidget {
  const AdaptiveFilledButton({@required this.child, this.onPressed})
      : assert(child != null);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) =>
      CupertinoButton.filled(onPressed: onPressed, child: child);

  @override
  Widget buildMaterialWidget(BuildContext context) => RaisedButton(
    onPressed: onPressed,
    child: child,
  );
}
