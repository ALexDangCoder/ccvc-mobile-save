import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/utils/constants/image_asset.dart';

class ThongBaoWidget extends StatelessWidget {
  final int sum;

  const ThongBaoWidget({Key? key, this.sum = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              ImageAssets.icThongBao,
              height: 18.0.textScale(space: 8),
              width: 18.0.textScale(space: 8),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4.0.textScale(space: 1),
                vertical: 1,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: statusCalenderRed,
              ),
              child: Text(
                sumThongBao(),
                style: textNormalCustom(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String sumThongBao() {
    if (sum >= 10) {
      return '9+';
    }
    return sum.toString();
  }
}
