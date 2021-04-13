import 'package:flutter/widgets.dart';
import 'package:poke_dapp/common/utils.dart';

abstract class AdaptiveState<T extends StatefulWidget> extends State<T> {
  Widget buildCupertinoWidget(BuildContext context);

  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) => isIOS
      ? buildCupertinoWidget(context)
      : buildMaterialWidget(context);
}
