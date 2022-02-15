import 'package:ccvc_mobile/config/resources/color.dart';

import 'package:ccvc_mobile/config/themes/app_theme.dart';


import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/day_time_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/info_user_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/mequee_widget.dart';

import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      color: AppTheme.getInstance().backGroundColor(),
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -120),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.headerBackground),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            height: 166,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
                  child:const InfoUserWidget(),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 14),
                    child:const DayTimeWidget(),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 65,
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 16),
              child: const MarqueeWidget(),
            ),
          )
        ],
      ),
    );
  }
}
