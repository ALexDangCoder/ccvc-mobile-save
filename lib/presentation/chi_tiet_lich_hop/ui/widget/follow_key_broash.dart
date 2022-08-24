import 'package:flutter/material.dart';

class FollowKeyBoardEdt extends StatefulWidget {
  final Widget child;
  final Widget? bottomWidget;

  const FollowKeyBoardEdt({
    Key? key,
    this.bottomWidget,
    required this.child,
  }) : super(key: key);

  @override
  _FollowKeyBoardEdtState createState() => _FollowKeyBoardEdtState();
}

class _FollowKeyBoardEdtState extends State<FollowKeyBoardEdt> {
  EdgeInsets _viewInsert = EdgeInsets.zero;

  double mouseRegion = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _viewInsert = mediaQuery.viewPadding.copyWith(
      bottom: mediaQuery.viewInsets.bottom,
    );
    return MouseRegion(
      onHover: (data) {
        mouseRegion = mediaQuery.size.height - data.position.dy;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: widget.child),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.bottomWidget ?? const SizedBox(),
          ),
          SizedBox(
            height: viewInsertPadding(),
          ),
        ],
      ),
    );
  }

  double viewInsertPadding() {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  double viewInsertPaddingIos() {
    return _viewInsert.bottom;
  }
}
