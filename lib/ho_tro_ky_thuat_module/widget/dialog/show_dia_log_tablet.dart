import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future<T?> showDiaLogTablet<T>(
  BuildContext context, {
  required String title,
  required Widget child,
  String? btnRightTxt,
  String? btnLeftTxt,
  bool isBottomShow = true,
  required Function() funcBtnOk,
  double maxHeight = 878,
  double width = 592,
  double? setHeight,
  bool showButtomTablet = false,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        clipBehavior: Clip.antiAlias,
        child: _DiaLogFeatureWidget(
          title: title,
          btnLeftTxt: btnLeftTxt ?? S.current.dong,
          btnRightTxt: btnRightTxt ?? S.current.them,
          funcBtnOk: funcBtnOk,
          isBottomShow: isBottomShow,
          maxHeight: setHeight ?? maxHeight,
          width: width,
          showButtonTapLet: showButtomTablet,
          child: child,
        ),
      );
    },
  );
}

class _DiaLogFeatureWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final String btnRightTxt;
  final String btnLeftTxt;
  final Function() funcBtnOk;
  final bool isBottomShow;
  final double maxHeight;
  final double width;
  final bool showButtonTapLet;

  const _DiaLogFeatureWidget({
    Key? key,
    required this.title,
    required this.child,
    required this.btnLeftTxt,
    required this.btnRightTxt,
    required this.funcBtnOk,
    required this.isBottomShow,
    required this.maxHeight,
    required this.width,
    required this.showButtonTapLet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      width: width,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: textNormalCustom(fontSize: 20, color: textTitle),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(ImageAssets.icClose),
                  )
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: child,
              ),
            ),
            if (isBottomShow)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: btnLeftTxt,
                    ),
                    spaceW20,
                    button(
                      onTap: () {
                        funcBtnOk();
                      },
                      title: btnRightTxt,
                      isLeft: false,
                    )
                  ],
                ),
              )
            else
              const SizedBox(),
            if (showButtonTapLet)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: btnLeftTxt,
                    ),
                  ],
                ),
              )
            else
              const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget button({
    required Function onTap,
    required String title,
    bool isLeft = true,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 44,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isLeft
              ? AppTheme.getInstance().colorSelect().withOpacity(0.1)
              : AppTheme.getInstance().colorSelect(),
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: 16,
              color: isLeft
                  ? AppTheme.getInstance().colorSelect()
                  : backgroundColorApp,
            ),
          ),
        ),
      ),
    );
  }
}
