import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_icon.dart';
import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/presentation/home_screen/ui/widgets/day_time_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/info_user_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom:20),
      color: backgroundColorApp,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -120),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(headerUrlIcon()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16,),
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: const Color(0xff6566E9).withOpacity(0.1),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
                  child: const InfoUserWidget(),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 14,),
                  child: const DayTimeWidget(),
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   left: 0,
          //   child: Container(
          //     height: 65,
          //     color: Colors.transparent,
          //     margin: const EdgeInsets.only(left: 16),
          //     child: const MarqueeWidget(),
          //   ),
          // )
        ],
      ),
    );
  }
}
