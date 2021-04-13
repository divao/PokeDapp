import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_dapp/generated/l10n.dart';
import 'package:poke_dapp/presentation/common/adaptive_app_bar_action.dart';
import 'package:poke_dapp/presentation/common/adaptive_stateless_widget.dart';
import 'package:poke_dapp/presentation/common/pd_annotated_region.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:poke_dapp/presentation/common/view_utils.dart';

class AdaptiveScaffold extends AdaptiveStatelessWidget {
  const AdaptiveScaffold({
    @required this.body,
    Key key,
    this.title,
    this.action,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.brightness,
  })  : assert(body != null),
        super(key: key);

  final String title;
  final AdaptiveAppBarAction action;
  final Widget body;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;
  final Brightness brightness; // Define a cor dos ícones da status bar

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    final route = ModalRoute.of(context);
    return title != null
        ? CupertinoPageScaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      navigationBar: CupertinoNavigationBar(
        // Atualmente o texto 'Close' está hardcoded, então replicamos
        // a lógica utilizada pelo flutter no arquivo nav_bar.dart e
        // substituímos o texto por 'Fechar'
        leading:
        route is PageRoute && route.canPop && route.fullscreenDialog
            ? CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => route.navigator.maybePop(),
          child: Text(
            S.of(context).closeButtonText,
          ),
        )
            : null,
        brightness: brightness ?? PDTheme.of(context).lightBrightness,
        // actionsForegroundColor: PDTheme.of(context).surfaceColor,
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        middle: Text(
          title,
          maxLines: 1,
          style: TextStyle(
            color: PDTheme.of(context).surfaceColor,
          ),
        ),
        trailing: action,
      ),
      backgroundColor: backgroundColor,
      child: body,
    )
        : PDAnnotatedRegion(
      brightness: brightness,
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        child: body,
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) => title != null
      ? Scaffold(
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    appBar: AppBar(
      brightness: brightness ?? PDTheme.of(context).darkBrightness,
      iconTheme: IconThemeData(
        color: PDTheme.of(context).surfaceColor,
      ),
      elevation: 0,
      title: Text(
        title,
        maxLines: 1,
        style: TextStyle(
          color: PDTheme.of(context).surfaceColor,
          fontWeight: FontWeightUtils.semiBold,
          fontSize: 20,
          letterSpacing: 0.15,
        ),
      ),
      actions: action != null ? <Widget>[action] : null,
    ),
    backgroundColor: backgroundColor,
    body: body,
  )
      : PDAnnotatedRegion(
    brightness: brightness,
    child: Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      body: body,
    ),
  );
}
