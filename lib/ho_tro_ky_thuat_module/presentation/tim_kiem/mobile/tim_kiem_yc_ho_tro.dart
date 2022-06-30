import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/tim_kiem/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
as p;
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
import 'package:flutter_svg/svg.dart';
class TimKiemYcHoTro extends StatefulWidget {
  const TimKiemYcHoTro({Key? key}) : super(key: key);

  @override
  State<TimKiemYcHoTro> createState() => _TimKiemYcHoTroState();
}

class _TimKiemYcHoTroState extends State<TimKiemYcHoTro> {


  String? ngayYeuCau;
  String? ngayHoanThanh;
  @override
  Widget build(BuildContext context) {
    return Container(
      //todo đang để tạm
      height: 600,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH20,
            Center(
              child: Container(
                height: 6,
                width: 48,
                decoration: const BoxDecoration(
                  color: colorECEEF7,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 22.5,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.tim_kiem,
                    style: p.textNormalCustom(
                      color: textTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  spaceH16,
                  dropDownField(title: S.current.don_vi),
                  spaceH16,
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: S.current.ngay_yeu_cau,
                          style: tokenDetailAmount(
                            fontSize: 14,
                            color: color3D5586,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceH8,
                  DateInput(
                    paddings: 10,
                    leadingIcon:
                    SvgPicture.asset(image_utils.ImageAssets.icCalenders),
                    onSelectDate: (dateTime) {
                      ngayYeuCau = dateTime;
                    },
                    initDateTime: DateTime.tryParse(ngayYeuCau ?? ''),
                  ),
                  spaceH16,
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: S.current.ngay_hoan_thanh,
                          style: tokenDetailAmount(
                            fontSize: 14,
                            color: color3D5586,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceH8,
                  DateInput(
                    paddings: 10,
                    leadingIcon:
                    SvgPicture.asset(image_utils.ImageAssets.icCalenders),
                    onSelectDate: (dateTime) {
                      ngayHoanThanh = dateTime;
                    },
                    initDateTime: DateTime.tryParse(ngayHoanThanh ?? ''),
                  ),
                  spaceH16,
                  dropDownField(title: S.current.nguoi_tiep_nhan_yeu_cau),
                  spaceH16,
                  dropDownField(title: S.current.nguoi_xu_ly),
                  spaceH16,
                  dropDownField(title: S.current.khu_vuc),
                  spaceH16,
                  dropDownField(title: S.current.toa_nha),
                  spaceH16,
                  dropDownField(title: S.current.so_phong),
                  spaceH16,
                  dropDownField(title: S.current.trang_thai_xu_ly),
                  spaceH20,
                  doubleBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dropDownField({
    String? hintText,
    int maxLine = 1,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: color3D5586,
                ),
              ),
            ],
          ),
        ),
        spaceH8,
        CoolDropDown(
          initData: 'huy đz',
          placeHoder: S.current.chon,
          onChange: (value) {},
          listData: ["huy", "huy1", "huy2"],
        )
      ],
    );
  }

  Widget doubleBtn() => Padding(
    padding: const EdgeInsets.only(
      left: 21,
      right: 21,
      top: 24,
    ),
    child: DoubleButtonBottom(
      onPressed1: () {

      },
      title1: S.current.dong,
      title2: S.current.gui_yc,
      onPressed2: () {

      },
    ),
  );
}
