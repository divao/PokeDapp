import 'package:flutter/material.dart';
import 'package:poke_dapp/common/utils.dart';
import 'package:provider/provider.dart';

abstract class PDTheme {
  PDTheme(
      this._basePrimaryColor, {
        this.lightPrimaryColor,
        this.sectionColor,
        this.surfaceColor,
        this.lightSurfaceColor,
        this.overlayColor,
        this.dividerColor,
        this.elevatedSurfaceColor,
        this.highlightedSurfaceColor,
        this.primaryTextColor,
        this.secondaryTextColor,
        this.helperTextColor,
        this.disabledTextColor,
        this.buttonTextColor,
        this.bottomNavigationBarItemColor,
        this.bottomNavigationBarShadowColor,
        this.white,
        this.transparent = const Color(0x00000000),
        this.disabledCameraColor = const Color(0xFF000000),
        this.errorColor = const Color(0xFFE23939),
        this.successColor = const Color(0xFF7CB342),
        this.minimumPriceColor = const Color(0xFF7EAE38),
        this.higherPriceColor = const Color(0xFFE23939),
        this.averagePriceColor = const Color(0xFFFBC02D),
        this.roundedBorderCardShadow,
        this.lightBrightness = Brightness.light,
        this.darkBrightness = Brightness.dark,
        this.key,
      }) {
    primaryColor = MaterialColor(
      _basePrimaryColor.value,
      {
        50: _basePrimaryColor.withOpacity(.1),
        100: _basePrimaryColor.withOpacity(.2),
        200: _basePrimaryColor.withOpacity(.3),
        300: _basePrimaryColor.withOpacity(.4),
        400: _basePrimaryColor.withOpacity(.5),
        500: _basePrimaryColor.withOpacity(.6),
        600: _basePrimaryColor.withOpacity(.7),
        700: _basePrimaryColor.withOpacity(.8),
        800: _basePrimaryColor.withOpacity(.9),
        900: _basePrimaryColor.withOpacity(1),
      },
    );
  }

  static PDTheme of(
      BuildContext context, {
        bool listen = false,
      }) =>
      Provider.of<PDTheme>(
        context,
        listen: listen,
      );

  static const lightThemeKey = 'light';
  static const darkThemeKey = 'dark';
  static const systemThemeKey = 'system';

  final Color _basePrimaryColor;

  /// Usada para destaque, sele????o, barras, bot??es,
  /// bot??es e textos que precisam de destaque, a????es de maior relev??ncia,
  /// como borda de bot??es de m??dia relev??ncia e chips.
  Color primaryColor;

  /// Usada para dar destaque aos textos.
  final Color lightPrimaryColor;

  /// Usada para figurar se????es.
  final Color sectionColor;

  /// Usada em superf??cies.
  final Color surfaceColor;

  /// Usada em superf??cies elevadas.
  final Color lightSurfaceColor;

  /// Usada em cards.
  final Color overlayColor;

  /// Usada para separar conte??do.
  final Color dividerColor;

  /// Usada no fundo de alguns cards.
  final Color elevatedSurfaceColor;

  /// Usada no fundo de cards destacados.
  final Color highlightedSurfaceColor;

  /// Usada em informa????es de maior relev??ncia
  /// e em t??tulos e subt??tulos de textos.
  final Color primaryTextColor;

  /// Usada em informa????es com menor relev??ncia e em corpos de textos.
  final Color secondaryTextColor;

  /// Usada em barras de busca, em campos de inser????o de informa????o e como
  /// informativos que precisam de pouco destaque.
  final Color helperTextColor;

  /// Usada em situa????es onde o texto est?? desabilitado,
  /// impossibilitando a????es naquele contexto.
  final Color disabledTextColor;

  /// Usada em bot??es e em textos das barras.
  final Color buttonTextColor;

  /// Cor utilizada nos icones da BottomNavigationBar
  final Color bottomNavigationBarItemColor;

  /// Cor utilizada na sombra da BottomNavigationBar
  final Color bottomNavigationBarShadowColor;

  /// Cor utilizada na sombra do RoundedBorderCard
  final Color roundedBorderCardShadow;

  final Color white;

  final Color transparent;
  final Color disabledCameraColor;
  final Color errorColor;
  final Color successColor;
  final Color minimumPriceColor;
  final Color higherPriceColor;
  final Color averagePriceColor;

  final Brightness lightBrightness;
  final Brightness darkBrightness;

  final ValueKey key;
}

class PDThemeLight extends PDTheme {
  PDThemeLight()
      : super(
    const Color(0xFFef5350),
    lightPrimaryColor: const Color(0xFFFCF2E1),
    sectionColor: const Color(0xFF666666),
    surfaceColor: const Color(0xFFFFFFFF),
    lightSurfaceColor: const Color(0xFFFFFFFF),
    overlayColor: const Color(0xFFFFFFFF),
    dividerColor: const Color(0x1F000000),
    elevatedSurfaceColor: const Color(0xFFF5F5F5),
    highlightedSurfaceColor: const Color(0xFFFCF2E1),
    primaryTextColor: const Color(0xFF191919),
    secondaryTextColor: const Color(0xFF666666),
    helperTextColor: const Color(0xFF7F7F7F),
    disabledTextColor: const Color(0xFFA8A8A8),
    buttonTextColor: const Color(0xFFFFFFFF),
    bottomNavigationBarItemColor: const Color(0xB2000000),
    white: const Color(0xFFE7E7E7),
    bottomNavigationBarShadowColor: const Color(0x33000000),
    roundedBorderCardShadow: const Color(0x33000000),
    lightBrightness: isIOS ? Brightness.dark : Brightness.light,
    darkBrightness: isIOS ? Brightness.light : Brightness.dark,
    key: const ValueKey(PDTheme.lightThemeKey),
  );
}

class PDThemeDark extends PDTheme {
  PDThemeDark()
      : super(
    const Color(0xFFef5350),
    lightPrimaryColor: const Color(0xFFFBBA54),
    sectionColor: const Color(0xFFB8B8B8),
    surfaceColor: const Color(0xFF121212),
    lightSurfaceColor: const Color(0xFF333333),
    overlayColor: const Color(0x11FFFFFF),
    dividerColor: const Color(0x33FFFFFF),
    elevatedSurfaceColor: const Color(0x11FFFFFF),
    highlightedSurfaceColor: const Color(0xFF4f4125),
    primaryTextColor: const Color(0xFFE7E7E7),
    secondaryTextColor: const Color(0xFFB8B8B8),
    helperTextColor: const Color(0xFF888888),
    disabledTextColor: const Color(0xFF626262),
    buttonTextColor: const Color(0xFF121212),
    bottomNavigationBarItemColor: const Color(0xB2FFFFFF),
    white: const Color(0xFFE7E7E7),
    bottomNavigationBarShadowColor: const Color(0xFF000000),
    roundedBorderCardShadow: const Color(0x22000000),
    lightBrightness: isIOS ? Brightness.light : Brightness.dark,
    darkBrightness: isIOS ? Brightness.dark : Brightness.light,
    key: const ValueKey(PDTheme.darkThemeKey),
  );
}
