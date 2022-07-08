import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/expanded_pakn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownTrangThaiPAKN extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const DropDownTrangThaiPAKN({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<DropDownTrangThaiPAKN> createState() => _DropDownTrangThaiPAKNState();
}

class _DropDownTrangThaiPAKNState extends State<DropDownTrangThaiPAKN> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: 230,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: borderColor.withOpacity(
            0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
        color: AppTheme.getInstance().dfBtnTxtColor(),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpandPAKNWidget(
              name: S.current.tiep_nhan,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH12,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter =
                            YKienNguoiDanCubitt.ChoTiepNhan;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: AppTheme.getInstance().choXuLyColor(),
                      title: S.current.cho_tiep_nhan,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.PhanXuLy;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: AppTheme.getInstance().subTitleColor(),
                      title: S.current.phan_xu_ly,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.DangXuLy;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: textColorForum,
                      title: S.current.dang_xu_ly,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiVanBanDi = 1;
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.getPAKNTiepNhanCacVanBan();
                      },
                      colorBG: AppTheme.getInstance().choXuLyColor(),
                      title: S.current.cho_tao_van_ban_di,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiVanBanDi = 2;
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.getPAKNTiepNhanCacVanBan();
                      },
                      colorBG: daXuLyColor,
                      title: S.current.da_cho_van_ban_di,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter =
                            YKienNguoiDanCubitt.DaHoanThanh;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: daXuLyColor,
                      title: S.current.da_hoan_thanh,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter =
                            YKienNguoiDanCubitt.ChoBoSungThongTin;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: AppTheme.getInstance().choXuLyColor(),
                      title: S.current.cho_bo_sung_thong_tin,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter =
                            YKienNguoiDanCubitt.TuChoiTiepNhan;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: redChart,
                      title: S.current.bi_tu_choi_tiep_nhan,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.HuyBo;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = 'TiepNhan';
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: redChart,
                      title: S.current.bi_huy_bo,
                    ),
                    spaceH16,
                    item(
                      callBack: (value) {
                        widget.cubit.textFilter.add(value);
                        widget.cubit.isShowFilterList.add(false);
                        widget.cubit.trangThaiFilter =
                            YKienNguoiDanCubitt.ChuyenXuLy;
                        widget.cubit.hanXuLy = null;
                        widget.cubit.loaiMenu = "TiepNhan";
                        widget.cubit.isFilterXuLy = false;
                        widget.cubit.isFilterTiepNhan = false;
                        widget.cubit.getDanhSachPAKNFilterChart();
                      },
                      colorBG: purpleChart,
                      title: S.current.chuyen_xu_ly,
                    ),
                  ],
                ),
              ),
            ),
            spaceH20,
            ExpandPAKNWidget(
              name: S.current.xu_ly,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH12,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter =
                          YKienNguoiDanCubitt.ChoTiepNhanXuLy;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: AppTheme.getInstance().choXuLyColor(),
                    title: S.current.cho_tiep_nhan_xu_ly,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter =
                          YKienNguoiDanCubitt.ChoPhanCongXuLy;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: AppTheme.getInstance().choXuLyColor(),
                    title: S.current.cho_phan_cong_xu_ly,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter =
                          YKienNguoiDanCubitt.DaPhanCong;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: daXuLyColor,
                    title: S.current.da_phan_cong,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ChoXuLy;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: textColorForum,
                    title: S.current.cho_xu_ly,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ChoDuyet;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: textColorForum,
                    title: S.current.cho_duyet,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.trangThaiVanBanDi = 1;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.getPAKNTiepNhanCacVanBan();
                    },
                    colorBG: textColorForum,
                    title: S.current.cho_tao_van_ban_di,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.trangThaiVanBanDi = 2;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.getPAKNTiepNhanCacVanBan();
                    },
                    colorBG: greenChart,
                    title: S.current.da_cho_van_ban_di,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter =
                          YKienNguoiDanCubitt.DaHoanThanh;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: greenChart,
                    title: S.current.da_hoan_thanh,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.daChoYKien = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDSPAKNXuLyChoVaDaChoYKien();
                    },
                    colorBG: textColorForum,
                    title: S.current.cho_cho_y_kien,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.daChoYKien = true;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDSPAKNXuLyChoVaDaChoYKien();
                    },
                    colorBG: greenChart,
                    title: S.current.da_cho_y_kien,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ThuHoi;

                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: redChart,
                    title: S.current.thu_hoi,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter =
                          YKienNguoiDanCubitt.TuChoiTiepNhan;

                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: redChart,
                    title: S.current.tra_lai,
                  ),
                  spaceH16,
                  item(
                    callBack: (value) {
                      widget.cubit.textFilter.add(value);
                      widget.cubit.isShowFilterList.add(false);
                      widget.cubit.hanXuLy = null;
                      widget.cubit.loaiMenu = 'XuLy';
                      widget.cubit.trangThaiFilter =
                          YKienNguoiDanCubitt.ChuyenXuLy;
                      widget.cubit.isFilterXuLy = false;
                      widget.cubit.isFilterTiepNhan = false;
                      widget.cubit.getDanhSachPAKNFilterChart();
                    },
                    colorBG: purpleChart,
                    title: S.current.chuyen_xu_ly,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget item({
  required Color colorBG,
  required String title,
  required Function(TextTrangThai) callBack,
}) {
  return InkWell(
    onTap: () => callBack(TextTrangThai(title, colorBG)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            color: colorBG,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: textNormalCustom(
                color: AppTheme.getInstance().dfBtnTxtColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
