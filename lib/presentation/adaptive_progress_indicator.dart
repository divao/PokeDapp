import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/common/utils.dart';

class AdaptativeProgressIndicator extends StatelessWidget {
  Widget _buildMaterialndicator(BuildContext context) =>
      const CircularProgressIndicator();

  Widget _buildCupertinoIndicator(BuildContext context) =>
      const CupertinoActivityIndicator(
        radius: 15,
      );

  @override
  Widget build(BuildContext context) => Center(
    child: isIOS
        ? _buildCupertinoIndicator(context)
        : _buildMaterialndicator(context),
  );
}