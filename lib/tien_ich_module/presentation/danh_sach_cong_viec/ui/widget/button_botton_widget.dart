

import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';

class ButtonCustomBottomDSCV extends StatefulWidget {
  final bool isColorBlue;
  final String title;
  final Function onPressed;
  final double? size;

  const ButtonCustomBottomDSCV({
    Key? key,
    required this.isColorBlue,
    required this.title,
    this.size,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonCustomBottomDSCVState createState() => _ButtonCustomBottomDSCVState();
}

class _ButtonCustomBottomDSCVState extends State<ButtonCustomBottomDSCV> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onPressed();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: checkPading(8, 12.0),
                vertical: checkPading(12, 22),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0.textScale(space: 4.0)),
                color: AppTheme.getInstance().colorField(),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: textNormalCustom(
                    fontSize: widget.size ?? 14.0.textScale(space: 4.0),
                    color: backgroundColorApp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double checkPading(double sizeMobile, double SizeTablet) {
    if (isMobile()) {
      return sizeMobile;
    }
    return SizeTablet;
  }
}