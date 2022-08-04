import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<T?> showDiaLogTablet<T>(
  BuildContext context, {
  required String title,
  required String title1,
  required String title2,
  required Widget child,
  String? btnRightTxt,
  String? btnLeftTxt,
  bool isBottomShow = true,
  required Function funcBtnOk,
  bool isBottomShowText = true,
  double maxHeight = 165,
  double width = 342,
  double? setHeight,
  bool isPhone = false,
  bool? isCallApi,
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
          title1: title1,
          title2: title2,
          isBottomShowText: isBottomShowText,
          isPhone: isPhone,
          isCallApi: isCallApi,
          child: child,
        ),
      );
    },
  );
}

class _DiaLogFeatureWidget extends StatelessWidget {
  final String title;
  final String title1;
  final String title2;
  final Widget child;
  final String btnRightTxt;
  final String btnLeftTxt;
  final Function funcBtnOk;
  final bool isBottomShow;
  final double maxHeight;
  final double width;
  final bool isBottomShowText;
  final bool isPhone;
  final bool? isCallApi;

  const _DiaLogFeatureWidget({
    Key? key,
    required this.title,
    required this.title1,
    required this.title2,
    required this.child,
    required this.btnLeftTxt,
    required this.btnRightTxt,
    required this.funcBtnOk,
    required this.isBottomShow,
    required this.maxHeight,
    required this.width,
    required this.isBottomShowText,
    required this.isPhone,
    this.isCallApi,
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
              margin: EdgeInsets.only(top: isPhone ? 40 : 30),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: isBottomShowText
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: textNormalCustom(
                            fontSize: isPhone ? 14 : 18,
                            color: textTitle,
                          ),
                        ),
                        Container(
                          width: 2,
                        ),
                        Text(
                          title1,
                          style: textNormalCustom(
                            fontSize: isPhone ? 14 : 18,
                            color: AppTheme.getInstance().colorField(),
                          ),
                        ),
                        Container(
                          width: 2,
                        ),
                        Text(
                          title2,
                          style: textNormalCustom(
                            fontSize: isPhone ? 14 : 18,
                            color: textTitle,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: textNormalCustom(
                        fontSize: isPhone ? 14 : 18,
                        color: textTitle,
                      ),
                      textAlign: TextAlign.center,
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
                        Navigator.pop(context, isCallApi ?? true);
                      },
                      title: btnRightTxt,
                      isLeft: false,
                    )
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
        height: isPhone ? 30 : 44,
        width: isPhone ? 110 : 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isLeft
              ? AppTheme.getInstance().colorField().withOpacity(0.1)
              : AppTheme.getInstance().colorField(),
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: isPhone ? 14 : 16,
              color: isLeft
                  ? AppTheme.getInstance().colorField()
                  : backgroundColorApp,
            ),
          ),
        ),
      ),
    );
  }
}
