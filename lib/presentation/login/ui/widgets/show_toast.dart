import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowToast extends StatelessWidget {
  final String text;

  const ShowToast({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorFF9F43.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(ImageAssets.icError),
          ),
          spaceW12,
          Text(
            text,
            style: tokenDetailAmount(color: color3D5586, fontSize: 14),
          )
        ],
      ),
    );
  }
}