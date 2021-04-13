import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:poke_dapp/presentation/route_name_builder.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

// When navigating through deep links, we need to push each path individually
// and using the correct context.
class DeepLinkHandler extends Handler {
  DeepLinkHandler(this.builder)
      : assert(builder != null),
        super(
          type: HandlerType.route,
          handlerFunc: (context, params) {
            final deepLink = params[RouteNameBuilder.deepLinkQueryParameter]?.first;

            // If a deep link parameter is specified, we wrap the widget in a
            // widget that will display it and push the next route on top of
            // it.
            return deepLink == null
                ? builder(context, params)
                : _DeepLinkNavigationWrapper(
              routeName: ModalRoute.of(context).settings.name,
              child: builder(context, params),
            );
          });
  final Widget Function(
      BuildContext,
      Map<String, List<String>> parameters,
      ) builder;
}

/// Displays the child widget and pushes another route on top of it.
class _DeepLinkNavigationWrapper extends StatefulWidget {
  const _DeepLinkNavigationWrapper({
    @required this.routeName,
    @required this.child,
    Key key,
  })  : assert(routeName != null),
        assert(child != null),
        super(key: key);

  final Widget child;
  final String routeName;

  @override
  _DeepLinkNavigationWrapperState createState() =>
      _DeepLinkNavigationWrapperState();
}

class _DeepLinkNavigationWrapperState
    extends State<_DeepLinkNavigationWrapper> {
  @override
  void initState() {
    final currentRouteUri = Uri.parse(widget.routeName);
    final deepLinkArgument = currentRouteUri.queryParameters[RouteNameBuilder.deepLinkQueryParameter];

    final deepLinkPaths = deepLinkArgument.split('/');
    final nextPathIndex =
        deepLinkPaths.indexOf(currentRouteUri.path.split('/').last) + 1;

    // It means we've reached the last deep link route.
    if (nextPathIndex >= deepLinkPaths.length) {
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final queryString = '?${currentRouteUri.query}';
      final routeFactory = Provider.of<RouteFactory>(context, listen: false);
      final nextRoute = _findNextRoute(
        deepLinkPaths,
        queryString,
        nextPathIndex,
        routeFactory,
      );

      final isFullScreenDialog =
          (nextRoute is MaterialPageRoute && nextRoute.fullscreenDialog) ||
              (nextRoute is CupertinoPageRoute && nextRoute.fullscreenDialog);

      Navigator.of(context, rootNavigator: isFullScreenDialog).push(
        nextRoute,
      );
    });

    super.initState();
  }

  /// Finds the matching the route by first matching the path, than the path
  /// with the previous path, then the previous path until the next path.
  /* Example for the path '18' on a 'country-filter/18/site-filter' deep link.
   First try: 18. No matches.
   Second try: country-filter/18. No matches.
   Third try: country-filter/18/site-filter. Founds a matching route.
  */
  Route<dynamic> _findNextRoute(
      List<String> paths,
      String query,
      int nextPathIndex,
      RouteFactory routeFactory,
      ) =>
      _matchRoute(
        paths.sublist(nextPathIndex, nextPathIndex + 1).join('/'),
        query,
        routeFactory,
      ) ??
          _matchRoute(
            paths.sublist(nextPathIndex - 1, nextPathIndex + 1).join('/'),
            query,
            routeFactory,
          ) ??
          _matchRoute(
            paths.sublist(nextPathIndex - 1, nextPathIndex + 2).join('/'),
            query,
            routeFactory,
          );

  /// Builds a route name with the path and the query and matches it against the
  /// RouteFactory.
  Route<dynamic> _matchRoute(
      String path,
      String query,
      RouteFactory routeFactory,
      ) {
    final routeSettings = RouteSettings(
      name: '$path$query',
    );

    return routeFactory(routeSettings);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Alias for the deep link handler function.
typedef DeepLinkNavigator = Function(String deepLink);
