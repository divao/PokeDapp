import 'package:flutter/material.dart';
import 'package:poke_dapp/presentation/common/pd_theme.dart';
import 'package:provider/provider.dart';
import 'package:poke_dapp/presentation/common/bottom_navigation/bottom_navigation_tab.dart';

class MaterialBottomNavigation extends StatefulWidget {
  const MaterialBottomNavigation({
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
  _MaterialBottomNavigationState createState() =>
      _MaterialBottomNavigationState();
}

class _MaterialBottomNavigationState extends State<MaterialBottomNavigation> {
  final _shouldBuildTab = <bool>[];

  @override
  void initState() {
    super.initState();
    _shouldBuildTab.addAll(
      List<bool>.filled(widget.navigationTabs.length, false),
    );
  }

  Widget _buildPageFlow(
      BuildContext context, int index, BottomNavigationTab navigationTab) {
    final isCurrentSelection = index == widget.selectedIndex;
    _shouldBuildTab[index] = isCurrentSelection || _shouldBuildTab[index];

    return _shouldBuildTab[index]
        ? Navigator(
            key: navigationTab.navigatorKey,
            initialRoute: navigationTab.routeName,
            onGenerateRoute: Provider.of<RouteFactory>(context, listen: false),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: widget.selectedIndex,
          children: widget.navigationTabs
              .map(
                (tab) => _buildPageFlow(
                  context,
                  widget.navigationTabs.indexOf(tab),
                  tab,
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: PDTheme.of(context).bottomNavigationBarShadowColor,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: widget.selectedIndex,
            items: widget.navigationTabs
                .map((tab) => tab.bottomNavigationBarItem)
                .toList(),
            onTap: (index) => widget.onItemSelected(index),
            backgroundColor: PDTheme.of(context).lightSurfaceColor,
            selectedItemColor: PDTheme.of(context).primaryColor,
            unselectedItemColor: PDTheme.of(context).secondaryTextColor,
          ),
        ),
      );
}
