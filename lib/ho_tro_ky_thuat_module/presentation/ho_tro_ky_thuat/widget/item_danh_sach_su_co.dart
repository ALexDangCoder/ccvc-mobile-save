import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/cubit/chi_tiet_ho_tro_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/tablet/cap_nhat_tinh_hinh_ho_tro_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/tablet/danh_gia_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/widget/cap_nhat_tinh_hinh_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/widget/danh_gia_yeu_cau_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/sua_htkt/mobile/sua_yc_ho_tro_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/sua_htkt/tablet/suc_yc_ho_tro_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDanhSachSuCo extends StatefulWidget {
  final SuCoModel objDSSC;
  final HoTroKyThuatCubit cubit;
  final Function(SuCoModel, int) onClickMore;
  final int index;
  final Function onClose;
  final int flexTitle;
  final int flexBody;
  final bool isTablet;

  const ItemDanhSachSuCo({
    Key? key,
    required this.objDSSC,
    required this.cubit,
    required this.onClickMore,
    required this.index,
    required this.onClose,
    this.flexTitle = 1,
    this.flexBody = 3,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<ItemDanhSachSuCo> createState() => _ItemDanhSachSuCoState();
}

class _ItemDanhSachSuCoState extends State<ItemDanhSachSuCo> {
  Widget textRow({
    required String textTitle,
    required String textContent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: widget.flexTitle,
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
          flex: widget.flexBody,
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
    required String textTitle,
    required String textContent,
    required Color statusColor,
  }) {
    return Row(
      children: [
        Expanded(
          flex: widget.flexTitle,
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
          flex: widget.flexBody,
          child: textContent.isNotEmpty
              ? Column(
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
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClose(),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: widget.isTablet ? 28 : 16,
              vertical: widget.isTablet ? 14 : 8,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.isTablet ? bgTabletItem : colorNumberCellQLVB,
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
                  textContent: widget.objDSSC.thoiGianYeuCau ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.mo_ta_su_co,
                  textContent: (widget.objDSSC.moTaSuCo ?? '').parseHtml(),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.nguoi_yeu_cau,
                  textContent: widget.objDSSC.nguoiYeuCau ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.don_vi,
                  textContent: widget.objDSSC.donVi ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.dia_chi,
                  textContent: widget.objDSSC.diaChi ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.dien_thoai,
                  textContent: widget.objDSSC.soDienThoai ?? '',
                ),
                spaceH10,
                textStatusRow(
                  textTitle: S.current.trang_thai_xu_ly,
                  textContent: widget.objDSSC.trangThaiXuLy ?? '',
                  statusColor: statusColor(widget.objDSSC.codeTrangThai ?? ''),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.ket_qua_xu_ly,
                  textContent: (widget.objDSSC.ketQuaXuLy ?? '').parseHtml(),
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.nguoi_xu_ly,
                  textContent: widget.objDSSC.nguoiXuLy ?? '',
                ),
                spaceH10,
                textRow(
                  textTitle: S.current.ngay_hoan_thanh,
                  textContent: widget.objDSSC.ngayHoanThanh ?? '',
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 38,
            child: ((widget.cubit.isManager || widget.cubit.isSupporter) &&
                    !(widget.objDSSC.codeTrangThai ==
                            HoTroKyThuatCubit.DA_HOAN_THANH ||
                        widget.objDSSC.codeTrangThai ==
                            HoTroKyThuatCubit.TU_CHOI_XU_LY) ||
                    widget.cubit.checkUser(widget.objDSSC.idNguoiYeuCau ?? ''))
                ? InkWell(
                    onTap: () =>
                        widget.onClickMore(widget.objDSSC, widget.index),
                    child: SvgPicture.asset(
                      ImageAssets.ic_more,
                      height: 20,
                      width: 20,
                    ),
                  )
                : const SizedBox(),
          ),
          Positioned(
            top: 47,
            right: 30,
            child: widget.cubit.listCheckPopupMenu[widget.index]
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
                        if (widget.objDSSC.codeTrangThai ==
                            HoTroKyThuatCubit.CHUA_XU_LY) ...[
                          itemMenu(
                            title: S.current.sua,
                            icon: ImageAssets.ic_edit,
                            function: (value) {
                              if (widget.isTablet) {
                                showDialog(
                                  context: context,
                                  builder: (_) => SuaDoiYcHoTroTablet(
                                    cubit: widget.cubit,
                                    idHTKT: widget.objDSSC.id ?? '',
                                  ),
                                );
                              } else {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => SuaDoiYcHoTroMobile(
                                    cubit: widget.cubit,
                                    idHTKT: widget.objDSSC.id ?? '',
                                  ),
                                ).whenComplete(
                                  () => {
                                    widget.cubit.onClosePopupMenu(),
                                    setState(() {}),
                                  },
                                );
                              }
                            },
                          ),
                          line(
                            paddingLeft: 35,
                          ),
                          itemMenu(
                            title: S.current.xoa,
                            icon: ImageAssets.ic_delete,
                            function: (value) {
                              widget.cubit
                                  .deleteTask(id: widget.objDSSC.id ?? '')
                                  .then((value) {
                                if (value) {
                                  MessageConfig.show(
                                    title: S.current.xoa_thanh_cong,
                                  );
                                  widget.cubit.getListDanhBaCaNhan(page: 1);
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
                        if ((widget.objDSSC.codeTrangThai ==
                                    HoTroKyThuatCubit.DA_HOAN_THANH ||
                                widget.objDSSC.codeTrangThai ==
                                    HoTroKyThuatCubit.TU_CHOI_XU_LY) &&
                            (widget.objDSSC.idNguoiYeuCau ==
                                HiveLocal.getDataUser()
                                    ?.userInformation
                                    ?.id)) ...[
                          itemMenu(
                            title: S.current.danh_gia,
                            icon: ImageAssets.ic_document_blue,
                            function: (value) {
                              if (widget.isTablet) {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: Center(
                                        child: DanhGiaYeuCauHoTroTabLet(
                                          cubit: ChiTietHoTroCubit(),
                                          idTask: widget.objDSSC.id,
                                        ),
                                      ),
                                    );
                                  },
                                ).whenComplete(
                                  () =>
                                      widget.cubit.getListDanhBaCaNhan(page: 1),
                                );
                              } else {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) {
                                    return DanhGiaYeuCauHoTro(
                                      cubit: ChiTietHoTroCubit(),
                                      idTask: widget.objDSSC.id,
                                    );
                                  },
                                ).whenComplete(
                                  () =>
                                      widget.cubit.getListDanhBaCaNhan(page: 1),
                                );
                              }
                            },
                          ),
                        ],
                        if ((widget.cubit.isSupporter ||
                                widget.cubit.isManager) &&
                            (!(widget.objDSSC.codeTrangThai ==
                                    HoTroKyThuatCubit.DA_HOAN_THANH) &&
                                !(widget.objDSSC.codeTrangThai ==
                                    HoTroKyThuatCubit.TU_CHOI_XU_LY)))
                          itemMenu(
                            title: S.current.chap_nhap_thxl,
                            icon: ImageAssets.ic_update,
                            function: (value) {
                              if (widget.isTablet) {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: Center(
                                        child: CapNhatTinhHinhHoTroTabLet(
                                          cubit: ChiTietHoTroCubit(),
                                          idTask: widget.objDSSC.id,
                                        ),
                                      ),
                                    );
                                  },
                                ).whenComplete(
                                  () =>
                                      widget.cubit.getListDanhBaCaNhan(page: 1),
                                );
                              } else {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) {
                                    return CapNhatTinhHinhHoTro(
                                      cubit: ChiTietHoTroCubit(),
                                      idTask: widget.objDSSC.id,
                                    );
                                  },
                                ).whenComplete(
                                  () =>
                                      widget.cubit.getListDanhBaCaNhan(page: 1),
                                );
                              }
                            },
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
}
