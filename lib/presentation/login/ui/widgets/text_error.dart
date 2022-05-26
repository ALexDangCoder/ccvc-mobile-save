import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetTextError extends StatelessWidget {
  final String text;

  const WidgetTextError({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20.0.textScale(),
          height: 20.0.textScale(),
          child: SvgPicture.asset(ImageAssets.icWarningRed),
        ),
        spaceW8,
        Text(
          text,
          style: textNormalCustom(
              color: titleItemEdit, fontSize: 12.0.textScale()),
        )
      ],
    );
  }
}
