import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDanhSachSuCo extends StatelessWidget {
  final DanhSachSuCoModel modelDSSC;
  final HoTroKyThuatCubit cubit;
  final Function(DanhSachSuCoModel, int) onClickMore;
  final int index;
  final Function onClose;

  const ItemDanhSachSuCo({
    Key? key,
    required this.modelDSSC,
    required this.cubit,
    required this.onClickMore,
    required this.index,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClose(),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
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
                  textContent: modelDSSC.thoiGianYeuCau ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.mo_ta_su_co,
                  textContent: modelDSSC.moTaSuCo ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.nguoi_yeu_cau,
                  textContent: modelDSSC.nguoiYeuCau ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.don_vi,
                  textContent: modelDSSC.donVi ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.dia_chi,
                  textContent: modelDSSC.diaChi ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.dien_thoai,
                  textContent: modelDSSC.soDienThoai ?? '',
                ),
                spaceH10,
                textStatusRow(
                  textTitle: S.current.trang_thai_xu_ly,
                  textContent: modelDSSC.trangThaiXuLy ?? '',
                  statusColor: statusColor(modelDSSC.trangThaiXuLy ?? ''),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.ket_qua_xu_ly,
                  textContent: modelDSSC.ketQuaXuLy ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.nguoi_xu_ly,
                  textContent: modelDSSC.nguoiXuLy ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.ngay_hoan_thanh,
                  textContent: modelDSSC.ngayHoanThanh ?? '',
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 24,
            child: InkWell(
              onTap: () => onClickMore(modelDSSC, index),
              child: SvgPicture.asset(
                ImageAssets.ic_more,
                height: 20,
                width: 20,
              ),
            ),
          ),
          Positioned(
            top: 47,
            right: 30,
            child: cubit.listCheckPopupMenu[index]
                ? Container(
                    width: 179,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColorApp,
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          12,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowContainerColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        itemMenu(
                          title: S.current.sua,
                          icon: ImageAssets.ic_edit,
                          function: (value) {},
                        ),
                        line(
                          paddingLeft: 35,
                        ),
                        itemMenu(
                          title: S.current.xoa,
                          icon: ImageAssets.ic_delete,
                          function: (value) {},
                        ),
                        line(
                          paddingLeft: 35,
                        ),
                        itemMenu(
                          title: S.current.danh_gia,
                          icon: ImageAssets.ic_document_blue,
                          function: (value) {},
                        ),
                        line(
                          paddingLeft: 35,
                        ),
                        itemMenu(
                          title: S.current.chap_nhap_thxl,
                          icon: ImageAssets.ic_update,
                          function: (value) {},
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Widget itemMenu({
    required String title,
    required String icon,
    required Function(String) function,
  }) {
    return GestureDetector(
      onTap: () => function(title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
              ),
            ),
            spaceW16,
            Expanded(
              flex: 11,
              child: Text(
                title,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case HoTroKyThuatCubit.DA_XU_LY:
        return daXuLyLuongColor;
      case HoTroKyThuatCubit.DANG_CHO_XU_LY:
        return processingColor;
      case HoTroKyThuatCubit.TU_CHOI_XU_LY:
        return statusCalenderRed;
      case HoTroKyThuatCubit.DANG_XU_LY:
        return blueColor;
      default:
        return statusCalenderRed;
    }
  }
}

Widget textRow({
  int flexTitle = 1,
  int flexBody = 3,
  required String textTitle,
  required String textContent,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
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
