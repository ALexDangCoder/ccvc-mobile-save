import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/extension_status.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_moi_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'item_menu_ket_thuc.dart';

class KetLuanHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final String id;

  KetLuanHopWidget({Key? key, required this.cubit, required this.id})
      : super(key: key);

  @override
  _KetLuanHopWidgetState createState() => _KetLuanHopWidgetState();
}

class _KetLuanHopWidgetState extends State<KetLuanHopWidget> {
  bool isShow = false;

  @override
  void initState() {
    widget.cubit.getXemKetLuanHop(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        title: S.current.ket_luan_hop,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<KetLuanHopModel>(
                  stream: widget.cubit.ketLuanHopStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return ItemKetLuanHopWidget(
                        title: S.current.ket_luan_hop,
                        time: data?.thoiGian ?? '',
                        trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                        tinhTrang: data?.tinhTrang ?? TinhTrang.TrungBinh,
                        id: widget.id,
                        cubit: widget.cubit,
                        onTap: () {
                          isShow = !isShow;
                          setState(() {});
                        },
                      );
                    } else {
                      return const SizedBox(
                        height: 200,
                        child: NodataWidget(),
                      );
                    }
                  },
                ),
                StreamBuilder<DanhSachNhiemVuLichHopModel>(
                  initialData: widget.cubit.danhSachNhiemVu,
                  stream: widget.cubit.streamDanhSachNhiemVuLichHop,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return ItemDanhSachNhiemVu(
                        hanXuLy: DateTime.parse(data?.hanXuLy ?? ''),
                        loaiNV: data?.loaiNhiemVu ?? '',
                        ndTheoDoi: data?.noiDungTheoDoi ?? '',
                        soNhiemVu: data?.soNhiemVu ?? '',
                        tinhHinhThucHien: data?.tinhHinhThucHienNoiBo ?? '',
                        trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                      );
                    } else {
                      return const SizedBox(
                        height: 200,
                        child: NodataWidget(),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<KetLuanHopModel>(
                  stream: widget.cubit.ketLuanHopStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return ItemKetLuanHopWidget(
                        title: S.current.ket_luan_hop,
                        time: data?.thoiGian ?? '',
                        trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                        tinhTrang: data?.tinhTrang ?? TinhTrang.TrungBinh,
                        id: widget.id,
                        cubit: widget.cubit,
                        onTap: () {
                          isShow = !isShow;
                          setState(() {});
                        },
                      );
                    } else {
                      return const SizedBox(
                        height: 200,
                        child: NodataWidget(),
                      );
                    }
                  },
                ),
                StreamBuilder<DanhSachNhiemVuLichHopModel>(
                  initialData: widget.cubit.danhSachNhiemVu,
                  stream: widget.cubit.streamDanhSachNhiemVuLichHop,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      return ItemDanhSachNhiemVu(
                        hanXuLy: DateTime.parse(data?.hanXuLy ?? ''),
                        loaiNV: data?.loaiNhiemVu ?? '',
                        ndTheoDoi: data?.noiDungTheoDoi ?? '',
                        soNhiemVu: data?.soNhiemVu ?? '',
                        tinhHinhThucHien: data?.tinhHinhThucHienNoiBo ?? '',
                        trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                      );
                    } else {
                      return const SizedBox(
                        height: 200,
                        child: NodataWidget(),
                      );
                    }
                  },
                )
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: const Alignment(0.9, 0.5),
                  child: MenuSelectWidget(
                    listSelect: [
                      QData(
                        urlImage: ImageAssets.icPlus2,
                        text: S.current.tao_moi_nhiem_vu,
                        onTap: () {
                          showDiaLogTablet(
                            context,
                            title: S.current.tao_moi_nhiem_vu,
                            child: const TaoMoiNhiemVuWidget(),
                            isBottomShow: false,
                            funcBtnOk: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.icMessage,
                        text: S.current.ket_luan_cuoc_hop,
                        onTap: () {
                          showDiaLogTablet(
                            context,
                            title: S.current.ket_luan_cuoc_hop,
                            child: XemKetLuanHopWidget(
                              cubit: widget.cubit,
                            ),
                            isBottomShow: false,
                            funcBtnOk: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.icDocument2,
                        text: S.current.gui_mail_ket_luan,
                        onTap: () {
                          showDiaLog(
                            context,
                            textContent:
                                S.current.ban_co_chac_chan_muon_gui_mai_nay,
                            btnLeftTxt: S.current.khong,
                            funcBtnRight: () {
                              widget.cubit.sendMailKetLuatHop(widget.id);
                            },
                            title: S.current.gui_email,
                            btnRightTxt: S.current.dong_y,
                            icon: SvgPicture.asset(ImageAssets.IcEmail),
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.Group2,
                        text: S.current.thu_hoi,
                        onTap: () {
                          showDiaLog(
                            context,
                            textContent:
                                S.current.ban_co_chac_chan_muon_thu_hoi_nay,
                            btnLeftTxt: S.current.khong,
                            funcBtnRight: () {
                              Navigator.pop(context);
                            },
                            title: S.current.thu_hoi_ket_luan_hop,
                            btnRightTxt: S.current.dong_y,
                            icon: SvgPicture.asset(ImageAssets.icThuHoiKL),
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.icDeleteRed,
                        text: S.current.xoa,
                        onTap: () {
                          showDiaLog(
                            context,
                            textContent:
                                S.current.ban_co_chac_chan_muon_xoa_klh_nay,
                            btnLeftTxt: S.current.khong,
                            funcBtnRight: () {
                              widget.cubit.deleteKetLuanHop(
                                  widget.cubit.xemKetLuanHopModel.id ?? '');
                            },
                            title: S.current.xoa_ket_luan_hop,
                            btnRightTxt: S.current.dong_y,
                            icon: SvgPicture.asset(ImageAssets.XoaKLHop),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ItemKetLuanHopWidget extends StatelessWidget {
  final String title;
  final String time;
  final TrangThai trangThai;
  final TinhTrang tinhTrang;
  final Function onTap;
  final DetailMeetCalenderCubit cubit;
  final String id;

  const ItemKetLuanHopWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.trangThai,
    required this.tinhTrang,
    required this.onTap,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0.textScale()),
      padding: EdgeInsets.all(16.0.textScale()),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        border: Border.all(color: bgDropDown),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textNormalCustom(
                  color: textTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                children: [
                  MenuSelectWidget(
                    listSelect: [
                      QData(
                        urlImage: ImageAssets.icPlus2,
                        text: S.current.tao_moi_nhiem_vu,
                        onTap: () {
                          showBottomSheetCustom(
                            context,
                            title: S.current.tao_moi_nhiem_vu,
                            child: const TaoMoiNhiemVuWidget(),
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.icDocument2,
                        text: S.current.ket_luan_cuoc_hop,
                        onTap: () {
                          showBottomSheetCustom(
                            context,
                            title: S.current.ket_luan_cuoc_hop,
                            child: XemKetLuanHopWidget(
                              cubit: cubit,
                            ),
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.icMessage,
                        text: S.current.gui_mail_ket_luan,
                        onTap: () {
                          showDiaLog(
                            context,
                            textContent:
                                S.current.ban_co_chac_chan_muon_gui_mai_nay,
                            btnLeftTxt: S.current.khong,
                            funcBtnRight: () {
                              cubit.sendMailKetLuatHop(id);
                            },
                            title: S.current.gui_email,
                            btnRightTxt: S.current.dong_y,
                            icon: SvgPicture.asset(ImageAssets.IcEmail),
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.Group2,
                        text: S.current.thu_hoi,
                        onTap: () {
                          showDiaLog(
                            context,
                            textContent:
                                S.current.ban_co_chac_chan_muon_thu_hoi_nay,
                            btnLeftTxt: S.current.khong,
                            funcBtnRight: () {
                              Navigator.pop(context);
                            },
                            title: S.current.thu_hoi_ket_luan_hop,
                            btnRightTxt: S.current.dong_y,
                            icon: SvgPicture.asset(ImageAssets.icThuHoiKL),
                          );
                        },
                      ),
                      QData(
                        urlImage: ImageAssets.icDeleteRed,
                        text: S.current.xoa,
                        onTap: () {
                          showDiaLog(
                            context,
                            textContent:
                                S.current.ban_co_chac_chan_muon_xoa_klh_nay,
                            btnLeftTxt: S.current.khong,
                            funcBtnRight: () {
                              cubit.deleteKetLuanHop(
                                  cubit.xemKetLuanHopModel.id ?? '');
                            },
                            title: S.current.xoa_ket_luan_hop,
                            btnRightTxt: S.current.dong_y,
                            icon: SvgPicture.asset(ImageAssets.XoaKLHop),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          widgetRow(
            name: S.current.thoi_gian,
            child: Text(
              time,
              style: textNormalCustom(
                color: textTitle,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          widgetRow(
            name: S.current.trang_thai,
            child: trangThai.getWidget(),
          ),
          widgetRow(
            name: S.current.tinh_trang,
            child: tinhTrang.getWidget(),
          ),
          widgetRow(
            name: S.current.file,
            child: Text(
              'filename.docx',
              style: textNormalCustom(
                color: choXuLyColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemDanhSachNhiemVu extends StatelessWidget {
  final String soNhiemVu;
  final String ndTheoDoi;
  final String tinhHinhThucHien;
  final DateTime hanXuLy;
  final String loaiNV;
  final TrangThai trangThai;

  const ItemDanhSachNhiemVu({
    Key? key,
    required this.soNhiemVu,
    required this.ndTheoDoi,
    required this.tinhHinhThucHien,
    required this.hanXuLy,
    required this.loaiNV,
    required this.trangThai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          S.current.danh_sach_nhiem_vu,
          style: textNormalCustom(
            fontWeight: FontWeight.w500,
            fontSize: 14.0.textScale(),
            color: dateColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16.0.textScale()),
          padding: EdgeInsets.all(16.0.textScale()),
          decoration: BoxDecoration(
            color: bgDropDown.withOpacity(0.1),
            border: Border.all(color: bgDropDown),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          S.current.so_nhiem_vu,
                          style: textNormalCustom(
                            color: titleColumn,
                            fontSize: 14.0.textScale(),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          soNhiemVu,
                          style: textNormalCustom(
                            color: textTitle,
                            fontSize: 14.0.textScale(),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(ImageAssets.ic_luong),
                  )
                ],
              ),
              widgetRow(
                name: S.current.noi_dung_theo_doi,
                child: Text(
                  ndTheoDoi,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              widgetRow(
                name: S.current.tinh_hinh_thuc_hien_noi_bo,
                child: Text(
                  tinhHinhThucHien,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              widgetRow(
                name: S.current.han_xu_ly,
                child: Text(
                  hanXuLy.toStringWithListFormat,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              widgetRow(
                name: S.current.loai_nv,
                child: Text(
                  loaiNV,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              widgetRow(
                name: S.current.trang_thai,
                child: trangThai.getWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget widgetRow({required String name, required Widget child}) {
  return Container(
    margin: EdgeInsets.only(top: 10.0.textScale()),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: textNormalCustom(
              color: titleColumn,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          ),
        ),
        Expanded(flex: 3, child: child),
      ],
    ),
  );
}
