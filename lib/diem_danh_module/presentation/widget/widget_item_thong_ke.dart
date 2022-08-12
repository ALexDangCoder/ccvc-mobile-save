import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetItemThongKe extends StatelessWidget {
  final ThongKeDiemDanhCaNhanModel thongKeDiemDanhCaNhanModel;

  const WidgetItemThongKe({
    Key? key,
    required this.thongKeDiemDanhCaNhanModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          itemthongKe(
            title: S.current.so_lan_di_muon,
            number: thongKeDiemDanhCaNhanModel.soLanDiMuon ?? 0,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              child: Divider(
                color: AppTheme.getInstance().lineColor(),
                height: 1,
              ),
            ),
          ),
          itemthongKe(
            title: S.current.so_lan_ve_som,
            number: thongKeDiemDanhCaNhanModel.soLanVeSom ?? 0,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              child: Divider(
                color: AppTheme.getInstance().lineColor(),
                height: 1,
              ),
            ),
          ),
          itemthongKe(
            title: S.current.so_ngay_nghi_co_ly_do,
            number: thongKeDiemDanhCaNhanModel.soNgayNghiCoLyDo ?? 0,
          ),
        ],
      ),
    );
  }

  Widget itemthongKe({required String title, required int number}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textNormalCustom(
              color: color667793,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            number.toString(),
            style: textNormalCustom(
              color: color667793,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
