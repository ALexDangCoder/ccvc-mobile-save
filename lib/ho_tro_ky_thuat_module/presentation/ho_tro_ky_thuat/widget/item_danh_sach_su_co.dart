import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ItemDanhSachSuCo extends StatelessWidget {
  const ItemDanhSachSuCo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorNumberCellQLVB,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: containerColorTab,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textRow(
            textTitle: S.current.thoi_gian_yeu_cau,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.mo_ta_su_co,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.nguoi_yeu_cau,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.don_vi,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.dia_chi,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.dien_thoai,
            textContent: S.current.all,
          ),
          spaceH10,
          textStatusRow(
            textTitle: S.current.trang_thai_xu_ly,
            textContent: S.current.all, statusColor: Colors.red, //todo
          ),
          spaceH10,
          textRow(
            textTitle: S.current.ket_qua_xu_ly,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.nguoi_xu_ly,
            textContent: S.current.all,
          ),
          spaceH10,
          textRow(
            textTitle: S.current.ngay_hoan_thanh,
            textContent: S.current.all,
          ),
          spaceH10,
        ],
      ),
    );
  }
}

Widget textRow({
  int flexTitle = 1,
  int flexBody = 3,
  required String textTitle,
  required String textContent,
}) {
  return Row(
    children: [
      Expanded(
        flex: flexTitle,
        child: Text(
          textTitle,
          style: textNormalCustom(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.getInstance().titleColor(),
          ),
        ),
      ),
      spaceW14,
      Expanded(
        flex: flexBody,
        child: Text(
          textContent,
          style: textNormalCustom(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.getInstance().titleColor(),
          ),
        ),
      )
    ],
  );
}

Widget textStatusRow({
  int flexTitle = 1,
  int flexBody = 3,
  required String textTitle,
  required String textContent,
  required Color statusColor,
}) {
  return Row(
    children: [
      Expanded(
        flex: flexTitle,
        child: Text(
          textTitle,
          style: textNormalCustom(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.getInstance().titleColor(),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      spaceW14,
      Expanded(
        flex: flexBody,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                textContent,
                style: textNormalCustom(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
