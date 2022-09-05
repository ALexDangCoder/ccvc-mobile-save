import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<T?> showDiaLog<T>(
  BuildContext context, {
  required String title,
  required String textContent,
  required Widget icon,
  required String btnRightTxt,
  required String btnLeftTxt,
  bool showTablet = false,
  bool isBottomShow = true,
  bool isOneButton = true,
  required Function funcBtnRight,
  Function()? funcBtnLeft,
  bool isCenterTitle = false,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: !isMobile()
              ? MediaQuery.of(dialogContext).size.width / 2
              : double.maxFinite,
          // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          padding: EdgeInsets.fromLTRB(
            24,
            !isMobile() ? 24 : 40,
            24,
            !isMobile() ? 32 : 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !isMobile(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(ImageAssets.icClose),
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
              icon,
              SizedBox(
                height: !isMobile() ? 20.0.textScale(space: -8) : 20,
              ),
              Text(
                title,
                style: titleAppbar(),
                textAlign: isCenterTitle ? TextAlign.center : null,
              ),
              if (isOneButton)
                Column(
                  children: [
                    SizedBox(
                      height: !isMobile() ? 14.0.textScale() : 14,
                    ),
                    Text(
                      textContent,
                      style: textNormal(
                        dateColor,
                        !isMobile() ? 14.0.textScale() : 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else
                const SizedBox(),
              SizedBox(
                height: !isMobile() ? 24.0.textScale(space: 8) : 24,
              ),
              if (isOneButton)
                Row(
                  children: [
                    Expanded(
                      child: ButtonCustomBottom(
                        isColorBlue: false,
                        title: btnLeftTxt,
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          if(funcBtnLeft != null){
                            funcBtnLeft();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: !isMobile() ? 16.0.textScale(space: 20) : 16,
                    ),
                    Expanded(
                      child: ButtonCustomBottom(
                        isColorBlue: true,
                        title: btnRightTxt,
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          funcBtnRight();
                        },
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      child: ButtonCustomBottom(
                        isColorBlue: true,
                        title: btnRightTxt,
                        onPressed: () {
                          Navigator.pop(dialogContext, true);
                          funcBtnRight();
                        },
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      );
    },
  );
}
