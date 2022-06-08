import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showDiaLogFeature(
  BuildContext context, {
  required String title,
  required Widget child,
  String btnRightTxt = '',
  String btnLeftTxt = '',
  bool isBottomShow = true,
  required Function funcBtnOk,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: backgroundColorApp,
        insetPadding: const EdgeInsets.symmetric(horizontal: 150),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: DiaLogFeatureWidget(
          title: title,
          btnLeftTxt: btnLeftTxt,
          btnRightTxt: btnRightTxt,
          funcBtnOk: funcBtnOk,
          isBottomShow: isBottomShow,
          child: child,
        ),
      );
    },
  );
}

class DiaLogFeatureWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final String btnRightTxt;
  final String btnLeftTxt;
  final Function funcBtnOk;
  final bool isBottomShow;

  const DiaLogFeatureWidget({
    Key? key,
    required this.title,
    required this.child,
    required this.btnLeftTxt,
    required this.btnRightTxt,
    required this.funcBtnOk,
    required this.isBottomShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 629),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24, left: 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Text(
                      title,
                      style:
                          textNormalCustom(color: color3D5586, fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(ImageAssets.icClose),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}
