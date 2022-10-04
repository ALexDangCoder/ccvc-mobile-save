import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowToast extends StatelessWidget {
  final String text;
  final String? icon;
  final Color? color;
  final double? withOpacity;
  final bool?isEnterLine;

  const ShowToast({
    Key? key,
    required this.text,
    this.icon,
    this.color,
    this.withOpacity,
    this.isEnterLine=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      constraints: BoxConstraints(
        maxWidth:  MediaQuery.of(context).size.width * (isMobile()? 0.8 : 0.5 )
      ),
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
          isEnterLine==true?
          Expanded(
            child: Text(
                text,
                softWrap: true,
                maxLines: 3,
                style: tokenDetailAmount(color: textTitle, fontSize: 14)
              ),
          )
          :
          Text(
              text,
              style: tokenDetailAmount(color: textTitle, fontSize: 14)
          )
        ],
      ),
    );
  }
}
