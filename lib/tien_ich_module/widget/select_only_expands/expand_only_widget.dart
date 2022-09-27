import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';

class ExpandOnlyWidget extends StatefulWidget {
  final bool initExpand;
  final Widget header;
  final Widget child;
  final bool isShowIcon;
  final AnimationController? initController;
  final Function onTap;
  bool? isTablet;
  bool showDecoration;
  EdgeInsets? paddingHeader;

  ExpandOnlyWidget({
    Key? key,
    this.initExpand = false,
    required this.child,
    required this.header,
    this.isShowIcon = true,
    this.initController,
    required this.onTap,
    this.isTablet,
    this.showDecoration = true,
    this.paddingHeader ,
  }) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandOnlyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  bool isExpanded = false;
  GroupProvider? groupProvider;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initExpand;
    prepareAnimations();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    groupProvider = GroupProvider.of(context);
    findGroupExpanded();
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
    expandController = widget.initController ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );
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

  @override
  void didUpdateWidget(ExpandOnlyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: widget.paddingHeader ??const  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 7.5,
            ),
            decoration: widget.showDecoration
                ? BoxDecoration(
                    color: widget.isTablet ?? false
                        ? backgroundColorApp
                        : borderColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: borderColor.withOpacity(0.5)),
                  )
                : null,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (expandController.value == 0) {
                      widget.onTap();
                    }
                    if (groupProvider != null) {
                      groupProvider!.expand(key);
                    } else {
                      isExpanded = !isExpanded;
                      _runExpandCheck();
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(child: widget.header),
                      if (widget.isShowIcon)
                        AnimatedBuilder(
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
                        )
                      else
                        const SizedBox()
                    ],
                  ),
                ) ,
                SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: animation,
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
