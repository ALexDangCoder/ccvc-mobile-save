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
  double height = 185;
  bool dropDownTC = true;
  bool dropDownXL = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
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

      ///height: 200 khi 1 item,
      ///70 khi thu gọn cả 2
      ///500 khi có 3 cái
      child: SizedBox(
        height: height,
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            return true;
          },
          child: SingleChildScrollView(
            child: StreamBuilder<List<bool>>(
                initialData: widget.cubit.constListValueDropdown,
                stream: widget.cubit.listValueDropDownBHVSJ.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item(
                        callBack: (value, index) {
                          widget.cubit.textFilter.add(value);
                          widget.cubit.isShowFilterList.add(false);
                          widget.cubit.setColorWhenChooseDropDown(index);
                          widget.cubit.resetBeforeRefresh();
                          widget.cubit.getDashBoardPAKNTiepCanXuLy();
                          widget.cubit.getDanhSachPAKN();
                          widget.cubit.textFilter.sink.add(
                            TextTrangThai(
                              S.current.all,
                              color3D5586,
                            ),
                          );
                        },
                        title: S.current.all,
                        index: YKienNguoiDanCubitt.INDEX_FILTER_ALL,
                        isChoosing: data[YKienNguoiDanCubitt.INDEX_FILTER_ALL],
                      ),
                      spaceH20,
                      ExpandPAKNWidget(
                        isFuncExpand: (value) {
                          dropDownTC = value;
                          if (dropDownTC == false && dropDownXL == false) {
                            height = 120;
                          } else {
                            height = 185;
                          }
                          setState(() {});
                        },
                        name: S.current.tiep_nhan,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceH12,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ChoTiepNhan;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.cho_tiep_nhan,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_TIEP_NHAN,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_TIEP_NHAN],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.PhanXuLy;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.phan_xu_ly,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_PHAN_XU_LY,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_PHAN_XU_LY],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.DangXuLy;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.dang_xu_ly,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_DANG_XU_LY,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_DANG_XU_LY],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ChoDuyet;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.cho_duyet,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_DUYET,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_DUYET],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiVanBanDi = 1;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getPAKNTiepNhanCacVanBan();
                                },
                                title: S.current.cho_tao_van_ban_di,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_TAO_VB_DI,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_TAO_VB_DI],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiVanBanDi = 2;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getPAKNTiepNhanCacVanBan();
                                },
                                title: S.current.da_cho_van_ban_di,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_DA_CHO_VB_DI,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_DA_CHO_VB_DI],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.DaHoanThanh;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.da_hoan_thanh,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_DA_HOAN_THANH,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_DA_HOAN_THANH],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ChoBoSungThongTin;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.cho_bo_sung_thong_tin,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_BSTT,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHO_BSTT],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.TuChoiTiepNhan;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.bi_tu_choi_tiep_nhan,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_BI_TU_CHOI_TIEP_NHAN,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_BI_TU_CHOI_TIEP_NHAN],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.HuyBo;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.bi_huy_bo,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_BI_HUY_BO,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_BI_HUY_BO],
                              ),

                              ///them
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);

                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ThuHoi;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;

                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.thu_hoi,
                                index:
                                    YKienNguoiDanCubitt.INDEX_FILTER_TC_THU_HOI,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_THU_HOI],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);

                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.TuChoiTiepNhan;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;

                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.tra_lai,
                                index:
                                    YKienNguoiDanCubitt.INDEX_FILTER_TC_TRA_LAI,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_TRA_LAI],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ChuyenXuLy;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu =
                                      YKienNguoiDanCubitt.TiepNhan;
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit
                                      .setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.chuyen_xu_ly,
                                index: YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHUYEN_XU_LY,
                                isChoosing: data[YKienNguoiDanCubitt
                                    .INDEX_FILTER_TC_CHUYEN_XU_LY],
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceH20,
                      ExpandPAKNWidget(
                        isFuncExpand: (value) {
                          dropDownXL = value;
                          if (dropDownXL == false && dropDownTC == false) {
                            height = 120;
                          } else {
                            height = 185;
                          }
                          setState(() {});
                        },
                        name: S.current.xu_ly,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spaceH12,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoTiepNhanXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_tiep_nhan_xu_ly,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_TIEP_NHAN_XL,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_TIEP_NHAN_XL],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoPhanCongXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_phan_cong_xu_ly,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_PHAN_CONG_XL,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_PHAN_CONG_XL],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.DaPhanCong;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.da_phan_cong,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_PHAN_CONG,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_PHAN_CONG],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_xu_ly,
                              index:
                                  YKienNguoiDanCubitt.INDEX_FILTER_XL_CHO_XU_LY,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_XU_LY],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoDuyet;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_duyet,
                              index:
                                  YKienNguoiDanCubitt.INDEX_FILTER_XL_CHO_DUYET,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_DUYET],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.trangThaiVanBanDi = 1;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getPAKNTiepNhanCacVanBan();
                              },
                              title: S.current.cho_tao_van_ban_di,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_TAO_VB_DI,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_TAO_VB_DI],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.trangThaiVanBanDi = 2;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getPAKNTiepNhanCacVanBan();
                              },
                              title: S.current.da_cho_van_ban_di,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_CHO_VB_DI,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_CHO_VB_DI],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.DaHoanThanh;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.da_hoan_thanh,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_HOAN_THANH,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_HOAN_THANH],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.daChoYKien = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDSPAKNXuLyChoVaDaChoYKien();
                              },
                              title: S.current.cho_cho_y_kien,
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_CHO_Y_KIEN,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHO_CHO_Y_KIEN],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.daChoYKien = true;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDSPAKNXuLyChoVaDaChoYKien();
                              },
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_CHO_Y_KIEN,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_DA_CHO_Y_KIEN],
                              title: S.current.da_cho_y_kien,
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ThuHoi;

                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              index:
                                  YKienNguoiDanCubitt.INDEX_FILTER_XL_THU_HOI,
                              isChoosing: data[
                                  YKienNguoiDanCubitt.INDEX_FILTER_XL_THU_HOI],
                              title: S.current.thu_hoi,
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.TuChoiTiepNhan;

                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              index:
                                  YKienNguoiDanCubitt.INDEX_FILTER_XL_TRA_LAI,
                              isChoosing: data[
                                  YKienNguoiDanCubitt.INDEX_FILTER_XL_TRA_LAI],
                              title: S.current.tra_lai,
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu =
                                    YKienNguoiDanCubitt.XULY;
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChuyenXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              index: YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHUYEN_XU_LY,
                              isChoosing: data[YKienNguoiDanCubitt
                                  .INDEX_FILTER_XL_CHUYEN_XU_LY],
                              title: S.current.chuyen_xu_ly,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

Widget item({
  required bool isChoosing,
  required String title,
  required int index,
  required Function(TextTrangThai, int index) callBack,
}) {
  return InkWell(
    onTap: () => callBack(TextTrangThai(title, textDefault), index),
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
            color: isChoosing ? textDefault : Colors.transparent,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: textNormalCustom(
                color: textTitle,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(),
        )
      ],
    ),
  );
}
