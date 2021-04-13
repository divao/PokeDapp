import 'package:flutter/material.dart';
import 'package:poke_dapp/presentation/common/adaptive_stateless_widget.dart';
import 'package:poke_dapp/presentation/common/selectable/cupertino_selectable.dart';

/// Makes the child widget selectable and gives it the visual feedback of
/// the selection.
class AdaptiveSelectable extends AdaptiveStatelessWidget {
  const AdaptiveSelectable({@required this.child, Key key, this.onTap})
      : assert(child != null),
        super(key: key);

  final GestureTapCallback onTap;
  final Widget child;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoSelectable(
    onTap: onTap,
    child: child,
  );

  @override
  Widget buildMaterialWidget(BuildContext context) => InkWell(
    onTap: onTap,
    child: child,
  );
}
