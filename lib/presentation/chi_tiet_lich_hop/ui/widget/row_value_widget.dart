import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RowDataWidget extends StatelessWidget {
  final String urlIcon;
  final String text;
  final TextStyle? styleText;
  final void Function()? onTab;

  const RowDataWidget({
    Key? key,
    required this.text,
    required this.urlIcon,
    this.styleText,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 17.0.textScale(),
          height: 17.0.textScale(),
          child: Center(
            child: SvgPicture.asset(
              urlIcon,
              width: 17.0.textScale(),
              height: 17.0.textScale(),
            ),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        if (isMobile())
          Expanded(
            child: SizedBox(
              child: textVl(),
            ),
          )
        else
          textVl(),
      ],
    );
  }

  Widget textVl() => GestureDetector(
        onTap: onTab,
        child: Text(
          text,
          style: styleText ?? textNormal(textTitle, 16),
        ),
      );
}
