import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/button_bottom.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<T?> showDiaLogTablet<T>(
  BuildContext context, {
  required String title,
  required Widget child,
  String? btnRightTxt,
  String? btnLeftTxt,
  bool isBottomShow = true,
  required Function() funcBtnOk,
  required Function() funcBtnPop,
  double maxHeight = 878,
  double width = 592,
  double? setHeight,
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
          funcBtnPop: funcBtnPop,
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
  final Function() funcBtnPop;
  final bool isBottomShow;
  final double maxHeight;
  final double width;

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
    required this.funcBtnPop,
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
                      funcBtnPop.call();
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
                        funcBtnPop.call();
                        Navigator.pop(context);
                      },
                      title: btnLeftTxt,
                    ),
                    spaceW20,
                    button(
                      onTap: () {
                        funcBtnOk();
                        Navigator.pop(context);
                      },
                      title: btnRightTxt,
                      isLeft: false,
                    )
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 30,
                ),
                child: ButtonBottom(
                  onPressed: () {
                    funcBtnOk();
                    Navigator.pop(context);
                  },
                  text: btnRightTxt,
                ),
              )
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
