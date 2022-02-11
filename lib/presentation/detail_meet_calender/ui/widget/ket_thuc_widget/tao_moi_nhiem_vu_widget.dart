import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_thuc_widget/drop_down_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaoMoiNhiemVuWidget extends StatelessWidget {
  const TaoMoiNhiemVuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: MediaQuery.of(context).size.height * 0.93,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      height: 6,
                      width: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Text(
                    S.current.tao_moi_nhiem_vu,
                    style: textNormalCustom(
                      color: titleColor,
                      fontSize: 18.0.textScale(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.0.textScale(),),
                  DropDownWidget(
                    isNote: true,
                    title: S.current.loai_nhiem_vu,
                    hint: S.current.loai_nhiem_vu,
                    listData: [
                      S.current.nhiem_vu_ubnd,
                      S.current.nhiem_vu_cpvpcp,
                      S.current.nhiem_vu_dv,
                    ],
                    onChange: (value) {
                    },
                  ),

                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: btnSuaLich(
                  name: S.current.dong,
                  bgr: buttonColor.withOpacity(0.1),
                  colorName: textDefault,
                  onTap: () {},
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: btnSuaLich(
                  name: S.current.xac_nhan,
                  bgr: labelColor,
                  colorName: Colors.white,
                  onTap: () {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget btnSuaLich({
  required String name,
  required Color bgr,
  required Color colorName,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgr,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorName,
        ),
      ),
    ),
  );
}
