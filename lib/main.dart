import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:poke_dapp/generated/l10n.dart';
import 'package:poke_dapp/pd_general_provider.dart';
import 'package:poke_dapp/presentation/common/adaptive_app.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'common/hive_initializer.dart';
import 'common/utils.dart';

class Log {
  final Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> logError(dynamic error) async {
    final stackTrace = error is Error ? error.stackTrace : null;
    logger.e('Usecase error', [error, stackTrace]);
    await logErrorOnFirebase(error, stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Provider.debugCheckInvalidValueType = null;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await hiveInitializer();

  final packageInfo = await PackageInfo.fromPlatform();

  await Firebase.initializeApp();
  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  final globalNavigatorKey = GlobalKey<NavigatorState>();

  timeago.setLocaleMessages(
    'pt_BR',
    timeago.PtBrShortMessages(),
  );

  return runApp(
    PDGeneralProvider(
      errorLogger: Log().logError,
      packageInfo: packageInfo,
      globalNavigatorKey: globalNavigatorKey,
      builder: (context) => MyApp(
        globalNavigatorKey: globalNavigatorKey,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    this.globalNavigatorKey,
    Key key,
}) : super(key: key);

  final GlobalKey<NavigatorState> globalNavigatorKey;

  @override
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'PokeDapp',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      primaryColor: PDTheme.of(context).primaryColor,
      cupertinoNavBarContrastColor: PDTheme.of(context).surfaceColor,
      analytics: Provider.of<FirebaseAnalytics>(context),
      screenNameExtractor: Provider.of<ScreenNameExtractor>(context),
      onGenerateRoute: Provider.of<RouteFactory>(context, listen: false),
      globalNavigatorKey: globalNavigatorKey,
    );
  }
}