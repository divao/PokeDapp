import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poke_dapp/presentation/common/adaptive_state.dart';
import 'package:poke_dapp/presentation/common/bottom_navigation/cupertino_bottom_navigation.dart';
import 'package:poke_dapp/presentation/common/bottom_navigation/material_bottom_navigation.dart';
import 'package:poke_dapp/presentation/common/deep_link_handler.dart';
import 'package:poke_dapp/presentation/route_name_builder.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_tab.dart';

class AdaptiveBottomNavigation extends StatefulWidget {
  const AdaptiveBottomNavigation({
    @required this.navigationTabs,
    Key key,
  })  : assert(navigationTabs != null),
        super(key: key);

  final List<BottomNavigationTab> navigationTabs;

  @override
  _AdaptiveBottomNavigationState createState() =>
      _AdaptiveBottomNavigationState();
}

class _AdaptiveBottomNavigationState
    extends AdaptiveState<AdaptiveBottomNavigation> {
  int _currentIndex = 0;

  NavigatorState get _activeNavigator =>
      widget.navigationTabs[_currentIndex].navigatorKey.currentState;

  @override
  void initState() {
    _getDynamicLink();
    super.initState();
  }

  Future _getDynamicLink() async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link;
    if (deepLink != null) {
      _openDeepLinkUri(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (dynamicLink) async {
        final deepLink = dynamicLink?.link;

        if (deepLink != null) {
          _openDeepLinkUri(deepLink);
        }
      },
    );
  }

  void _onTabSelected(int newIndex) {
    if (_currentIndex == newIndex) {
      widget.navigationTabs[newIndex].navigatorKey.currentState
          .popUntil((route) => route.isFirst);
    }

    if (Platform.isIOS) {
      _currentIndex = newIndex;
    } else {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) =>
      Provider<DeepLinkNavigator>(
        create: (_) => _openDeepLink,
        child: _MaybePopActiveNavigator(
          currentIndex: _currentIndex,
          navigationTabs: widget.navigationTabs,
          onTabSelected: _onTabSelected,
          child: CupertinoBottomNavigation(
            navigationTabs: widget.navigationTabs,
            onItemSelected: _onTabSelected,
            selectedIndex: _currentIndex,
          ),
        ),
      );

  @override
  Widget buildMaterialWidget(BuildContext context) =>
      Provider<DeepLinkNavigator>(
        create: (_) => _openDeepLink,
        child: _MaybePopActiveNavigator(
          currentIndex: _currentIndex,
          navigationTabs: widget.navigationTabs,
          onTabSelected: _onTabSelected,
          child: MaterialBottomNavigation(
            navigationTabs: widget.navigationTabs,
            onItemSelected: _onTabSelected,
            selectedIndex: _currentIndex,
          ),
        ),
      );

  void _openDeepLink(String deepLink) {
    final deepLinkUri = Uri.parse(deepLink);
    _openDeepLinkUri(deepLinkUri);
  }

  void _openDeepLinkUri(Uri deepLinkUri) {
    final pathSegments = deepLinkUri.pathSegments;
    if (pathSegments == null || pathSegments.isEmpty) {
      return;
    }

    final firstPathTabIndex = widget.navigationTabs
        .indexWhere((item) => item.routeName == pathSegments.first);

    final deepLinkQuery = deepLinkUri.query;

    if (firstPathTabIndex != -1) {
      if (firstPathTabIndex != _currentIndex) {
        setState(() {
          _currentIndex = firstPathTabIndex;
        });
      }

      // Garante que na troca de tabs o novo navegador
      // já terá sido instanciado. Para os casos em que essa seja
      // a primeira vez que ele está sendo aberto.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _activeNavigator.popUntil((route) => route.isFirst);
        if (pathSegments.length >= 2) {
          final routeFactory =
              Provider.of<RouteFactory>(context, listen: false);

          final path = StringBuffer();
          var pathIndex = 1;
          Route<dynamic> createdRoute;

          // Tenta construir um path válido antes de fazer o pushNamed
          // Ex: Se queremos navegar para a rota home/categoryProductList/id
          // nesse ponto testaremos primeiro a rota categoryProductList
          // se não for válida, testamos categoryProductList/id
          // que no nosso exemplo é válida, e aí sim fazemos o pushNamed
          do {
            path.write('/${pathSegments[pathIndex]}');
            createdRoute = routeFactory(
              RouteSettings(
                name: '$path',
              ),
            );
          } while (createdRoute == null && ++pathIndex < pathSegments.length);

          final routeName = '$path?'
              '${deepLinkQuery.isNotEmpty ? '$deepLinkQuery&' : ''}'
              '${RouteNameBuilder.deepLinkQueryParameter}='
              '${Uri.encodeComponent(deepLinkUri.path)}';

          _activeNavigator.pushNamed(
            routeName,
          );
        }
      });
    } else {
      final routeName = '${pathSegments.first}?'
          '${deepLinkQuery.isNotEmpty ? '$deepLinkQuery&' : ''}'
          '${RouteNameBuilder.deepLinkQueryParameter}='
          '${Uri.encodeComponent(deepLinkUri.path)}';

      Navigator.of(context)
        ..popUntil((route) => route.isFirst)
        ..pushNamed(routeName);
    }
  }
}

class _MaybePopActiveNavigator extends StatelessWidget {
  const _MaybePopActiveNavigator({
    @required this.child,
    @required this.currentIndex,
    @required this.navigationTabs,
    @required this.onTabSelected,
  })  : assert(child != null),
        assert(currentIndex != null),
        assert(navigationTabs != null),
        assert(onTabSelected != null);

  final Widget child;
  final int currentIndex;
  final List<BottomNavigationTab> navigationTabs;
  final Function onTabSelected;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => !await navigationTabs[currentIndex]
            .navigatorKey
            .currentState
            .maybePop(),
        child: child,
      );
}
