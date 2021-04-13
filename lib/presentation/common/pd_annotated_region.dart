import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';

class PDAnnotatedRegion extends StatelessWidget {
  const PDAnnotatedRegion({
    @required this.child,
    this.brightness,
  }) : assert(child != null);

  final Widget child;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarIconBrightness:
      brightness ?? PDTheme.of(context).darkBrightness,
      statusBarBrightness: brightness ?? PDTheme.of(context).darkBrightness,
    ),
    child: child,
  );
}
