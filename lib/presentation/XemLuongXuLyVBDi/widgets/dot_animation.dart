import 'package:flutter/material.dart';

class DotAnimationWidget extends StatefulWidget {
  const DotAnimationWidget({Key? key}) : super(key: key);

  @override
  _DotAnimationWidgetState createState() => _DotAnimationWidgetState();
}

class _DotAnimationWidgetState extends State<DotAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> animationOpacity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    animation = Tween<double>(begin: 25, end: 50).animate(animationController);
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: const Color(0xff62bd19).withOpacity(1- animationController.value), width: 3)),
        child: Center(
          child: Container(
            height: 25,
            width: 25,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xff62bd19)),
          ),
        ),
      ),
    );
  }
}
