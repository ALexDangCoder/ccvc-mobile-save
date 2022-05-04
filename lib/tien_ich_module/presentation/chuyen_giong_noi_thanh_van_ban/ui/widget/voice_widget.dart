import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/bloc/chuyen_giong_noi_thanh_van_ban_cubit.dart';
import 'package:flutter/material.dart';

class VoiceWidget extends StatelessWidget {
  final ChuyenGiongNoiThanhVanBanCubit cubit;

  VoiceWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final List<int> duration = [
    700,
    300,
    400,
    500,
    550,
    700,
    900,
    400,
    500,
    100,
    900,
    400,
    500,
    550,
    700
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        15,
        (index) => Musicvisualizer(
          duration: duration[index],
          color: AppTheme.getInstance().colorField(),
          cubit: cubit,
        ),
      ),
    );
  }
}

class Musicvisualizer extends StatefulWidget {
  final int duration;
  final Color color;
  final ChuyenGiongNoiThanhVanBanCubit cubit;

  const Musicvisualizer({
    Key? key,
    required this.duration,
    required this.color,
    required this.cubit,
  }) : super(key: key);

  @override
  _MusicvisualizerState createState() => _MusicvisualizerState();
}

class _MusicvisualizerState extends State<Musicvisualizer>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration,
      ),
    );
    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    );

    animation = Tween<double>(begin: 0, end: 28).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.forward();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3.34,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: animation.value,
    );
  }
}
