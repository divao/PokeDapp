import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_dapp/presentation/common/adaptive_stateless_widget.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:poke_dapp/presentation/common/view_utils.dart';

class AdaptiveApp extends AdaptiveStatelessWidget {
  const AdaptiveApp({
    @required this.primaryColor,
    @required this.title,
    @required this.onGenerateRoute,
    @required this.cupertinoNavBarContrastColor,
    @required this.analytics,
    @required this.screenNameExtractor,
    this.localizationsDelegates,
    this.supportedLocales,
    this.globalNavigatorKey,
    Key key,
  })  : assert(primaryColor != null),
        assert(title != null),
        assert(onGenerateRoute != null),
        assert(cupertinoNavBarContrastColor != null),
        assert(analytics != null),
        assert(screenNameExtractor != null),
        super(key: key);

  final Color primaryColor;
  final String title;
  final RouteFactory onGenerateRoute;
  final Iterable<Locale> supportedLocales;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Color cupertinoNavBarContrastColor;
  final FirebaseAnalytics analytics;
  final ScreenNameExtractor screenNameExtractor;
  final GlobalKey<NavigatorState> globalNavigatorKey;

  @override
  Widget buildCupertinoWidget(BuildContext context) => Theme(
    data: _buildMaterialThemeData(),
    child: CupertinoApp(
      title: title,
      theme: CupertinoThemeData(
        brightness: PDTheme.of(context).lightBrightness,
        primaryColor: primaryColor,
        textTheme: CupertinoTextThemeData(
          textStyle: const TextStyle(fontFamily: PDFontFamilies.nunito),
          // Para deixar o título da AppBar no iOS na cor correta
          navTitleTextStyle: CupertinoTheme.of(context)
              .textTheme
              .navTitleTextStyle
              .copyWith(
            color: cupertinoNavBarContrastColor,
            fontFamily: PDFontFamilies.nunito,
          ),
          primaryColor: cupertinoNavBarContrastColor,
        ),
        scaffoldBackgroundColor: PDTheme.of(context).surfaceColor,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: analytics,
          nameExtractor: screenNameExtractor,
        ),
      ],
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      navigatorKey: globalNavigatorKey,
    ),
  );

  @override
  Widget buildMaterialWidget(BuildContext context) => MaterialApp(
    title: title,
    themeMode: ThemeMode.light,
    theme: _buildMaterialThemeData(),
    onGenerateRoute: onGenerateRoute,
    navigatorObservers: [
      FirebaseAnalyticsObserver(
        analytics: analytics,
        nameExtractor: screenNameExtractor,
      ),
    ],
    localizationsDelegates: localizationsDelegates,
    supportedLocales: supportedLocales,
    navigatorKey: globalNavigatorKey,
  );

  ThemeData _buildMaterialThemeData() => ThemeData(
    primarySwatch: primaryColor,
    fontFamily: PDFontFamilies.nunito,
  );
}
