import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetChupAnhCMND extends StatefulWidget {
  final String title;

  const WidgetChupAnhCMND({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _WidgetChupAnhCMNDState createState() => _WidgetChupAnhCMNDState();
}

class _WidgetChupAnhCMNDState extends State<WidgetChupAnhCMND> {
  bool isAttack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(widget.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(isAttack ? S.current.bam_chup : S.current.bam_chon)],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 16.0, left: 16.0),
        child: isAttack
            ? SolidButton(
                isColorBlue: true,
                mainAxisAlignment: MainAxisAlignment.center,
                text: S.current.chup,
                urlIcon: ImageAssets.icCameraWhite,
                onTap: () {
                  isAttack = !isAttack;
                  setState(() {});
                  showDiaLog(
                    context,
                    title: S.current.hinh_anh_nhan_dien_khong_hop_le,
                    icon: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: choVaoSoColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.0)),
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        ImageAssets.icAlertDanger,
                      ),
                    ),
                    btnLeftTxt: S.current.dong,
                    btnRightTxt: S.current.thu_lai,
                    funcBtnRight: () {},
                    showTablet: false,
                    textAlign: TextAlign.start,
                    textContent:
                        '${S.current.mesage_thong_tin_khach}\n${S.current.mesage_thong_tin_khach1}\n'
                        '${S.current.mesage_thong_tin_khach2}\n${S.current.mesage_thong_tin_khach3}\n'
                        '${S.current.mesage_thong_tin_khach4}',
                  );
                },
              )
            : DoubleButtonBottom(
                onClickLeft: () {
                  isAttack = !isAttack;
                  setState(() {});
                },
                onClickRight: () {},
                title1: S.current.thu_lai,
                title2: S.current.chon,
              ),
      ),
    );
  }
}
