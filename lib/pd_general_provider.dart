import 'package:dio/dio.dart';
import 'package:domain/data_repository/pokemon_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_case/use_case_exporter.dart';
import 'package:domain/data_observables.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:poke_dapp/data/cache/data_source/pokemon_cds.dart';
import 'package:poke_dapp/data/cache/data_source/user_preferences_cds.dart';
import 'package:poke_dapp/data/remote/data_source/pokemon_rds.dart';
import 'package:poke_dapp/data/repository/pokemon_repository.dart';
import 'package:poke_dapp/data/repository/user_preferences_data_repository.dart';
import 'package:poke_dapp/presentation/common/deep_link_handler.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:poke_dapp/presentation/pokemon/list/pokemon_list_page.dart';
import 'package:poke_dapp/presentation/route_name_builder.dart';
import 'package:poke_dapp/main_content_screen.dart';
import 'package:poke_dapp/data/remote/infrastructure/poke_dapp_dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

class PDGeneralProvider extends StatefulWidget {
  const PDGeneralProvider({
    @required this.errorLogger,
    @required this.packageInfo,
    @required this.globalNavigatorKey,
    @required this.builder,
    Key key,
  })  : assert(errorLogger != null),
        assert(packageInfo != null),
        assert(globalNavigatorKey != null),
        assert(builder != null),
        super(key: key);

  final ErrorLogger errorLogger;
  final PackageInfo packageInfo;
  final GlobalKey<NavigatorState> globalNavigatorKey;
  final WidgetBuilder builder;

  @override
  _PDGeneralProviderState createState() => _PDGeneralProviderState();
}

class _PDGeneralProviderState extends State<PDGeneralProvider>
    with WidgetsBindingObserver {
  final _themePreferenceSubject = PublishSubject<void>();
  Brightness _platformBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _platformBrightness = WidgetsBinding.instance.window.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {
      _platformBrightness = WidgetsBinding.instance.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    _themePreferenceSubject.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._buildDataObservables(),
          Provider<Dio>(
            create: (context) {
              final options = BaseOptions(
                baseUrl: 'https://pokeapi.co/api/v2',
              );

              return PokeDappDio(options);
            },
          ),
          Provider<ErrorLogger>.value(
            value: widget.errorLogger,
          ),
          Provider<FirebaseAnalytics>(
            create: (_) => FirebaseAnalytics(),
          ),
          Provider<ScreenNameExtractor>(
            create: (_) =>
                (settings) => RouteNameBuilder.extractScreenName(settings.name),
          ),
          ..._buildRDSProviders(),
          ..._buildCDSProviders(),
          ..._buildRepositoryProviders(),
          ..._buildUCProviders(),
          ..._buildFluroProviders(),
        ],
        child: Consumer2<GetThemePreferenceUC, ThemePreferenceStreamWrapper>(
          builder: (_, getIsDark, themeUpdate, __) => StreamBuilder(
            stream: themeUpdate.value,
            builder: (context, _) => FutureBuilder(
              future: getIsDark.getFuture(),
              builder: (context, themePreference) {
                PDTheme pdTheme;
                if (themePreference == null ||
                    themePreference.data == null ||
                    themePreference.data == PDTheme.systemThemeKey) {
                  pdTheme = _platformBrightness == Brightness.dark
                      ? PDThemeDark()
                      : PDThemeLight();
                } else {
                  pdTheme = themePreference.data == PDTheme.darkThemeKey
                      ? PDThemeDark()
                      : PDThemeLight();
                }
                return Provider<PDTheme>.value(
                  value: pdTheme,
                  child: widget.builder(context),
                );
              },
            ),
          ),
        ),
      );

  List<SingleChildWidget> _buildDataObservables() => [
        Provider<ThemePreferenceStreamWrapper>(
          create: (_) =>
              ThemePreferenceStreamWrapper(_themePreferenceSubject.stream),
        ),
        Provider<ThemePreferenceSinkWrapper>(
          create: (_) =>
              ThemePreferenceSinkWrapper(_themePreferenceSubject.sink),
        ),
      ];

  List<SingleChildWidget> _buildRDSProviders() => [
        ProxyProvider<Dio, PokemonRDS>(
          update: (_, dio, __) => PokemonRDS(dio: dio),
        )
      ];

  List<SingleChildWidget> _buildCDSProviders() => [
        Provider<UserPreferencesCDS>(
          create: (_) => UserPreferencesCDS(),
        ),
        Provider<PokemonCDS>(
          create: (_) => PokemonCDS(),
        ),
      ];

  List<SingleChildWidget> _buildRepositoryProviders() => [
        ProxyProvider<UserPreferencesCDS, UserPreferencesRepository>(
          update: (_, userPreferencesCDS, __) => UserPreferencesRepository(
            userPreferencesCDS: userPreferencesCDS,
          ),
        ),
        ProxyProvider2<PokemonRDS, PokemonCDS, PokemonRepository>(
          update: (_, rds, cds, __) => PokemonRepository(
            pokemonRDS: rds,
            pokemonCDS: cds,
          ),
        ),
      ];

  List<SingleChildWidget> _buildUCProviders() => [
        ProxyProvider2<UserPreferencesRepository, ErrorLogger,
            GetThemePreferenceUC>(
          update: (
            _,
            repository,
            logger,
            __,
          ) =>
              GetThemePreferenceUC(
            repository: repository,
            logger: logger,
          ),
        ),
        ProxyProvider2<PokemonRepository, ErrorLogger,
            GetPokemonSummaryListUC>(
          update: (context, repository, errorLogger, _) =>
              GetPokemonSummaryListUC(
                  repository: repository, logger: errorLogger),
        ),
      ];

  List<SingleChildWidget> _buildFluroProviders() => [
        Provider<FluroRouter>(
            create: (context) => FluroRouter()
              ..define(
                '/',
                transitionType: TransitionType.native,
                handler: DeepLinkHandler(
                  (ctx, _) => MainContentScreen(),
                ),
              )
              ..define(
                '${RouteNameBuilder.pokemonScreen()}',
                transitionType: TransitionType.native,
                handler: DeepLinkHandler(
                  (context, params) => PokemonListPage.create(context),
                ),
              )
              ..define(
                '${RouteNameBuilder.favoritesScreen()}',
                transitionType: TransitionType.native,
                handler: DeepLinkHandler(
                  (context, params) => PokemonListPage.create(context),
                ),
              )),
        ProxyProvider<FluroRouter, RouteFactory>(
          update: (context, router, _) => (settings) => router
              .matchRoute(context, settings.name, routeSettings: settings)
              .route,
        ),
      ];
}
