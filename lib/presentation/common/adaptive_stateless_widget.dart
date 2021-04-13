import 'package:flutter/widgets.dart';
import 'package:poke_dapp/common/utils.dart';

abstract class AdaptiveStatelessWidget extends StatelessWidget {
  const AdaptiveStatelessWidget({Key key}) : super(key: key);

  Widget buildCupertinoWidget(BuildContext context);

  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) => isIOS
      ? buildCupertinoWidget(context)
      : buildMaterialWidget(context);
}
