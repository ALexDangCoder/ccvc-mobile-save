import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/material.dart';

class ExpandWidgetDetailMeetCalender extends StatefulWidget {
  final Widget child;
  final bool expand;
  final Widget title;
  final Function onChangeExpand;
  final Decoration? headerDecoration;
  final EdgeInsetsGeometry? paddingRightIcon;
  final Color? colorIcon;

  const ExpandWidgetDetailMeetCalender({
    Key? key,
    this.expand = false,
    required this.child,
    required this.title,
    required this.onChangeExpand,
    this.headerDecoration,
    this.colorIcon,
    this.paddingRightIcon,
  }) : super(key: key);

  @override
  _ExpandWidgetDetailMeetCalenderState createState() => _ExpandWidgetDetailMeetCalenderState();
}

class _ExpandWidgetDetailMeetCalenderState extends State<ExpandWidgetDetailMeetCalender>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
  CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
  Tween<double>(begin: 0.0, end: 0.5);
  late AnimationController expandController;
  late Animation<double> animation;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _iconTurns = expandController.drive(_halfTween.chain(_easeInTween));
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandWidgetDetailMeetCalender oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            widget.onChangeExpand();
          },
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [widget.title],
                  ),
                ),
                Padding(
                  padding: widget.paddingRightIcon ?? EdgeInsets.zero,
                  child: Center(
                    child: RotationTransition(
                      turns: _iconTurns,
                      child: const Icon(
                        Icons.expand_more,
                        color: AqiColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: widget.child,
        ),
      ],
    );
  }
}
