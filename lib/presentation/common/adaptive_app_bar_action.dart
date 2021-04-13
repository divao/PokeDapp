import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:poke_dapp/presentation/common/adaptive_stateless_widget.dart';

/// AppBar's action that renders differently depending on the platform
/// we're running on.
class AdaptiveAppBarAction extends AdaptiveStatelessWidget {
  const AdaptiveAppBarAction({@required this.child, Key key, this.onPressed})
      : assert(child != null),
        super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoButton(
    onPressed: onPressed,
    padding: EdgeInsets.zero,
    child: child,
  );

  @override
  Widget buildMaterialWidget(BuildContext context) => IconButton(
    icon: child,
    onPressed: onPressed,
  );
}
