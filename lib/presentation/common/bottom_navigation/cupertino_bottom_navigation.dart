import 'package:flutter/cupertino.dart';
import 'package:poke_dapp/presentation/common/bottom_navigation/bottom_navigation_tab.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:provider/provider.dart';

class CupertinoBottomNavigation extends StatelessWidget {
  const CupertinoBottomNavigation({
    @required this.navigationTabs,
    @required this.onItemSelected,
    @required this.selectedIndex,
    Key key,
  })  : assert(navigationTabs != null),
        assert(onItemSelected != null),
        assert(selectedIndex != null),
        super(key: key);

  final List<BottomNavigationTab> navigationTabs;
  final ValueChanged<int> onItemSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        controller: CupertinoTabController(initialIndex: selectedIndex),
        tabBar: CupertinoTabBar(
          items: navigationTabs
              .map(
                (item) => item.bottomNavigationBarItem,
              )
              .toList(),
          onTap: onItemSelected,
          activeColor: PDTheme.of(context).primaryColor,
          backgroundColor: PDTheme.of(context).lightSurfaceColor,
        ),
        tabBuilder: (context, index) {
          final barItem = navigationTabs[index];
          return CupertinoTabView(
            navigatorKey: barItem.navigatorKey,
            onGenerateRoute: (settings) {
              final routeFactory = Provider.of<RouteFactory>(
                context,
                listen: false,
              );
              if (settings.name == '/') {
                return routeFactory(
                  settings.copyWith(name: barItem.routeName),
                );
              } else {
                return routeFactory(settings);
              }
            },
          );
        },
      );
}
