import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCollapse extends StatefulWidget {
  const ItemCollapse({
    Key? key,
    required this.child,
    required this.title,
    this.initCollapse = true,
  }) : super(key: key);
  final Widget child;
  final bool initCollapse;
  final List<Widget> title;

  @override
  _ItemCollapseState createState() => _ItemCollapseState();
}

class _ItemCollapseState extends State<ItemCollapse>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  late bool isCollapse;

  @override
  void initState() {
    isCollapse = widget.initCollapse;
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

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
    if (isCollapse) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
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
            isCollapse = !isCollapse;
            setState(() {});
            _runExpandCheck();
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [...widget.title],
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: SvgPicture.asset(
                      isCollapse ? ImageAssets.ic_drop_down : ImageAssets.ic_up,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
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
