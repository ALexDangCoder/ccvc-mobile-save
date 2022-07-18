import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/them_htkt/mobile/them_moi_yc_ho_tro_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDanhSachSuCo extends StatelessWidget {
  final SuCoModel objDSSC;
  final HoTroKyThuatCubit cubit;
  final Function(SuCoModel, int) onClickMore;
  final int index;
  final Function onClose;

  const ItemDanhSachSuCo({
    Key? key,
    required this.objDSSC,
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
                  textContent: objDSSC.thoiGianYeuCau ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.mo_ta_su_co,
                  textContent: (objDSSC.moTaSuCo ?? '').parseHtml(),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.nguoi_yeu_cau,
                  textContent: objDSSC.nguoiYeuCau ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.don_vi,
                  textContent: objDSSC.donVi ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.dia_chi,
                  textContent: objDSSC.diaChi ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.dien_thoai,
                  textContent: objDSSC.soDienThoai ?? '',
                ),
                spaceH10,
                textStatusRow(
                  textTitle: S.current.trang_thai_xu_ly,
                  textContent: getTextStatus(objDSSC.codeTrangThai ?? ''),
                  statusColor: statusColor(objDSSC.codeTrangThai ?? ''),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.ket_qua_xu_ly,
                  textContent: (objDSSC.ketQuaXuLy ?? '').parseHtml(),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.nguoi_xu_ly,
                  textContent: objDSSC.nguoiXuLy ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.ngay_hoan_thanh,
                  textContent: objDSSC.ngayHoanThanh ?? '',
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 24,
            child: InkWell(
              onTap: () => onClickMore(objDSSC, index),
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
                        if (objDSSC.codeTrangThai ==
                            HoTroKyThuatCubit.CHUA_XU_LY) ...[
                          itemMenu(
                            title: S.current.sua,
                            icon: ImageAssets.ic_edit,
                            function: (value) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => ThemMoiYCHoTroMobile(
                                  cubit: cubit,
                                  statusHTKT: StatusHTKT.CHINH_SUA,
                                  modelEdit: objDSSC,
                                ),
                              );
                            },
                          ),
                          line(
                            paddingLeft: 35,
                          ),
                          itemMenu(
                            title: S.current.xoa,
                            icon: ImageAssets.ic_delete,
                            function: (value) {
                              cubit
                                  .deleteTask(id: objDSSC.id ?? '')
                                  .then((value) {
                                if (value) {
                                  MessageConfig.show(
                                    title: S.current.xoa_thanh_cong,
                                  );
                                  cubit.getListDanhBaCaNhan(page: 1);
                                } else {
                                  MessageConfig.show(
                                    title: S.current.xoa_that_bai,
                                  );
                                }
                              });
                            },
                          ),
                          line(
                            paddingLeft: 35,
                          ),
                        ],
                        if (!(cubit.isCheckUser ?? true))
                          itemMenu(
                            title: S.current.danh_gia,
                            icon: ImageAssets.ic_document_blue,
                            function: (value) {},
                          ),
                        if (!(cubit.isCheckUser ?? true))
                          line(
                            paddingLeft: 35,
                          ),
                        if ((cubit.isCheckUser ?? false) ||
                            !(objDSSC.codeTrangThai ==
                                HoTroKyThuatCubit.DA_HOAN_THANH))
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
    return InkWell(
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
      case HoTroKyThuatCubit.DA_HOAN_THANH:
        return daXuLyLuongColor;
      case HoTroKyThuatCubit.CHUA_XU_LY:
        return processingColor;
      case HoTroKyThuatCubit.TU_CHOI_XU_LY:
        return statusCalenderRed;
      case HoTroKyThuatCubit.DANG_XU_LY:
        return blueColor;
      default:
        return statusCalenderRed;
    }
  }

  String getTextStatus(String status) {
    switch (status) {
      case HoTroKyThuatCubit.DA_HOAN_THANH:
        return S.current.da_xu_ly;
      case HoTroKyThuatCubit.CHUA_XU_LY:
        return S.current.dang_cho_xu_ly;
      case HoTroKyThuatCubit.TU_CHOI_XU_LY:
        return S.current.tu_choi_xu_ly;
      case HoTroKyThuatCubit.DANG_XU_LY:
        return S.current.dang_xu_ly;
      default:
        return '';
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
