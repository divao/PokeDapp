import 'package:flutter/widgets.dart';

class BottomNavigationTab {
  const BottomNavigationTab({
    @required this.bottomNavigationBarItem,
    @required this.navigatorKey,
    @required this.routeName,
  })  : assert(bottomNavigationBarItem != null),
        assert(navigatorKey != null),
        assert(routeName != null);

  final BottomNavigationBarItem bottomNavigationBarItem;
  final GlobalKey<NavigatorState> navigatorKey;
  final String routeName;
}
