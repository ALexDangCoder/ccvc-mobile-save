import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';

class ExpandOnlyWidget extends StatefulWidget {
  final bool initExpand;
  final Widget header;
  final Widget child;
  final bool isShowIcon;
  final BoxDecoration? headerDecoration;
  final bool? isPaddingIcon;
  final double? paddingSize;
  final double? paddingTop;
  final double? paddingRightIcon;
  final AnimationController? initController;
  final Function(bool)? onchange;

  const ExpandOnlyWidget({
    Key? key,
    this.initExpand = false,
    required this.child,
    required this.header,
    this.headerDecoration,
    this.isShowIcon = true,
    this.initController,
    this.paddingRightIcon,
    this.isPaddingIcon,
    this.paddingSize,
    this.onchange,
    this.paddingTop,
  }) : super(key: key);

  @override
  ExpandedSectionState createState() => ExpandedSectionState();
}

class ExpandedSectionState extends State<ExpandOnlyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  bool isExpanded = false;
  GroupProvider? groupProvider;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      groupProvider = GroupProvider.of(context);
      findGroupExpanded();
    });

    // widget.onchange?.call(isExpanded);
  }

  void findGroupExpanded() {
    if (groupProvider != null) {
      groupProvider!.validator.addAll({key: widget.initExpand});
      groupProvider!.stream.listen((event) {
        _runExpandCheck();
      });
    }
    _runExpandCheck();
  }

  void prepareAnimations() {
    isExpanded = widget.initExpand;
    expandController = widget.initController ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        )
      ..value = widget.initExpand ? 1 : 0;
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.linear,
    );
  }

  void _runExpandCheck() {
    if (groupProvider != null) {
      final expand = groupProvider!.validator[key] ?? false;
      if (expand) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
    } else {
      if (isExpanded) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
    }
  }

  bool get isExpandedGroup => groupProvider!.validator[key] ?? false;

  @override
  void didUpdateWidget(ExpandOnlyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  void expandGesture() {
    if (groupProvider != null) {
      groupProvider!.validator[key] = true;
      _runExpandCheck();
    }
  }

  void collapseGesture() {
    if (groupProvider != null) {
      groupProvider!.validator[key] = false;
      _runExpandCheck();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (groupProvider != null) {
              groupProvider!.expand(key);
            } else {
              isExpanded = !isExpanded;
              _runExpandCheck();
            }
            if (expandController.value == 0) {
              widget.onchange?.call(true);
            } else {
              widget.onchange?.call(false);
            }
          },
          child: Container(
            decoration: widget.headerDecoration,
            child: Row(
              children: [
                Flexible(child: widget.header),
                if (widget.isShowIcon)
                  Padding(
                    padding: EdgeInsets.only(
                      top : widget.paddingTop ?? 0,
                      right: widget.isPaddingIcon == true
                          ? widget.paddingRightIcon ?? 16
                          : 0,
                    ),
                    child: AnimatedBuilder(
                      animation: expandController,
                      builder: (context, _) {
                        return expandController.value == 0
                            ? const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: AqiColor,
                              )
                            : const Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: AqiColor,
                              );
                      },
                    ),
                  )
                else
                  const SizedBox()
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
