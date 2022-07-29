import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowToast extends StatelessWidget {
  final String text;
  final String? icon;
  final Color? color;
  final double? withOpacity;

  const ShowToast({
    Key? key,
    required this.text,
    this.icon,
    this.color,
    this.withOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? redChart.withOpacity(withOpacity ?? 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(icon ?? ImageAssets.icError),
          ),
          spaceW12,
          Text(
            text,
            style: tokenDetailAmount(color: textTitle, fontSize: 14),
          )
        ],
      ),
    );
  }
}
