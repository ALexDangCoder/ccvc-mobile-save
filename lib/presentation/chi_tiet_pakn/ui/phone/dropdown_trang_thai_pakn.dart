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
                        title: S.current.all,index: 0, isChoosing: data[0],
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
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.cho_tiep_nhan,
                                index: 1, isChoosing: data[1],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.PhanXuLy;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.phan_xu_ly,
                                index: 2, isChoosing: data[2],

                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.DangXuLy;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.dang_xu_ly,
                                index: 3, isChoosing: data[3],
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
                                index: 4, isChoosing: data[4],
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
                                index: 5, isChoosing: data[5],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.DaHoanThanh;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.da_hoan_thanh,
                                index: 6, isChoosing: data[6],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ChoBoSungThongTin;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.cho_bo_sung_thong_tin,
                                index: 7, isChoosing: data[7],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.TuChoiTiepNhan;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.bi_tu_choi_tiep_nhan,
                                index: 8, isChoosing: data[8],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.HuyBo;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = 'TiepNhan';
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.bi_huy_bo,
                                index: 9, isChoosing: data[9],
                              ),
                              spaceH16,
                              item(
                                callBack: (value, index) {
                                  widget.cubit.textFilter.add(value);
                                  widget.cubit.isShowFilterList.add(false);
                                  widget.cubit.trangThaiFilter =
                                      YKienNguoiDanCubitt.ChuyenXuLy;
                                  widget.cubit.hanXuLy = null;
                                  widget.cubit.loaiMenu = "TiepNhan";
                                  widget.cubit.isFilterXuLy = false;
                                  widget.cubit.isFilterTiepNhan = false;
                                  widget.cubit.setColorWhenChooseDropDown(index);
                                  widget.cubit.getDanhSachPAKNFilterChart();
                                },
                                title: S.current.chuyen_xu_ly,
                                index: 10, isChoosing: data[10],
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
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoTiepNhanXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_tiep_nhan_xu_ly,
                              index: 11, isChoosing: data[11],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoPhanCongXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_phan_cong_xu_ly,
                              index: 12, isChoosing: data[12],
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
                              index: 13, isChoosing: data[13],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_xu_ly,
                              index: 14, isChoosing: data[14],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChoDuyet;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.cho_duyet,
                              index: 15, isChoosing: data[15],
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
                              index: 16, isChoosing: data[16],
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
                              index: 17, isChoosing: data[17],
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.DaHoanThanh;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              title: S.current.da_hoan_thanh,
                              index: 18, isChoosing: data[18],
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
                              index: 19, isChoosing: data[19],
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
                              index: 20, isChoosing: data[20],
                              title: S.current.da_cho_y_kien,
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ThuHoi;

                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              index: 21, isChoosing: data[21],
                              title: S.current.thu_hoi,
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.TuChoiTiepNhan;

                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              index: 22, isChoosing: data[22],
                              title: S.current.tra_lai,
                            ),
                            spaceH16,
                            item(
                              callBack: (value, index) {
                                widget.cubit.textFilter.add(value);
                                widget.cubit.isShowFilterList.add(false);
                                widget.cubit.hanXuLy = null;
                                widget.cubit.loaiMenu = 'XuLy';
                                widget.cubit.trangThaiFilter =
                                    YKienNguoiDanCubitt.ChuyenXuLy;
                                widget.cubit.isFilterXuLy = false;
                                widget.cubit.isFilterTiepNhan = false;
                                widget.cubit.setColorWhenChooseDropDown(index);
                                widget.cubit.getDanhSachPAKNFilterChart();
                              },
                              index: 23, isChoosing: data[23],
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
      ],
    ),
  );
}
