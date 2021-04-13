import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poke_dapp/generated/l10n.dart';
import 'package:poke_dapp/presentation/common/bottom_navigation/adaptive_bottom_navigation.dart';
import 'package:poke_dapp/presentation/common/bottom_navigation/bottom_navigation_tab.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:poke_dapp/presentation/route_name_builder.dart';

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  List<BottomNavigationTab> _navigationTabs;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final pdTheme = PDTheme.of(context, listen: true);

    _navigationTabs ??= [
      BottomNavigationTab(
        bottomNavigationBarItem: BottomNavigationBarItem(
          label: S.of(context).pokemonBottomNavigationItem,
          icon: Icon(Icons.pets),
        ),
        navigatorKey: _navigatorKeys[0],
        routeName: RouteNameBuilder.pokemonScreen(),
      ),
      BottomNavigationTab(
        bottomNavigationBarItem: BottomNavigationBarItem(
          label: S.of(context).favoritesBottomNavigationItem,
          icon: Icon(Icons.star),
        ),
        navigatorKey: _navigatorKeys[1],
        routeName: RouteNameBuilder.favoritesScreen(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) => AdaptiveBottomNavigation(
    navigationTabs: _navigationTabs,
  );
}
