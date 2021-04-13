import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Makes the child widget selectable and gives it the visual feedback of
/// the selection.
class CupertinoSelectable extends StatefulWidget {
  const CupertinoSelectable({@required this.child, Key key, this.onTap})
      : assert(child != null),
        super(key: key);

  final GestureTapCallback onTap;
  final Widget child;

  @override
  _CupertinoSelectableState createState() => _CupertinoSelectableState();
}

class _CupertinoSelectableState extends State<CupertinoSelectable> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: widget.onTap,
    onTapDown: (_) => setState(() {
      _isSelected = true;
    }),
    onTapUp: (_) => setState(() {
      _isSelected = false;
    }),
    onTapCancel: () => setState(() {
      _isSelected = false;
    }),
    child: Container(
      color:
      _isSelected ? Theme.of(context).splashColor : Colors.transparent,
      child: widget.child,
    ),
  );
}
