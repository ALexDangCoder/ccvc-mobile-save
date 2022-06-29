import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/xem_luong_xu_ly/xem_luong_xu_ly_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/extension_status.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/ket_luan_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_moi_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_with_title_widget.dart';

class KetLuanHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  KetLuanHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _KetLuanHopWidgetState createState() => _KetLuanHopWidgetState();
}

class _KetLuanHopWidgetState extends State<KetLuanHopWidget> {
  bool isShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!isMobile()) {
      widget.cubit.callApiKetLuanHop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (value) {
          if (value) {
            widget.cubit.callApiKetLuanHop();
          }
        },
        title: S.current.ket_luan_hop,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ketLuanHop(),
                textKetLuanHopNhiemVu(),
                listDanhSachNhiemVu()
              ],
            ),
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ketLuanHop(),
                  textKetLuanHopNhiemVu(),
                  listDanhSachNhiemVu()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textKetLuanHopNhiemVu() => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          S.current.danh_sach_nhiem_vu,
          style: textNormalCustom(
            fontWeight: FontWeight.w500,
            fontSize: 14.0.textScale(),
            color: dateColor,
          ),
        ),
      );

  Widget ketLuanHop() => StreamBuilder<KetLuanHopModel>(
        stream: widget.cubit.ketLuanHopSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (widget.cubit.isSoanKetLuanHop()) {
            return IconWithTiltleWidget(
              icon: ImageAssets.icDocument2,
              title: S.current.soan_ket_luan_hop,
              onPress: () {
                xemOrTaoKetLuanHop(widget.cubit, context);
              },
            );
          }
          if (data != null) {
            final data = snapshot.data;
            return Column(
              children: [
                ItemKetLuanHopWidget(
                  title: '${S.current.ket_luan_hop} (${data?.title ?? ''})',
                  time: data?.thoiGian ?? '',
                  trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                  tinhTrang: data?.tinhTrang ?? TinhTrang.TrungBinh,
                  id: widget.cubit.idCuocHop,
                  cubit: widget.cubit,
                  onTap: () {
                    isShow = !isShow;
                    setState(() {});
                  },
                  listFile: data?.file ?? [],
                ),
                if (widget.cubit.isDuyetOrHuyKetLuanHop())
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        ButtonOtherWidget(
                          text: S.current.duyet,
                          color: itemWidgetUsing,
                          ontap: () {
                            widget.cubit
                                .xacNhanHoacHuyKetLuanHop(isDuyet: true);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: ButtonOtherWidget(
                            text: S.current.tu_choi,
                            color: statusCalenderRed,
                            ontap: () {
                              widget.cubit
                                  .xacNhanHoacHuyKetLuanHop(isDuyet: false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }

          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: NodataWidget(),
          );
        },
      );

  Widget listDanhSachNhiemVu() =>
      StreamBuilder<List<DanhSachNhiemVuLichHopModel>>(
        stream: widget.cubit.danhSachNhiemVuLichHopSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data ?? [];
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ItemDanhSachNhiemVu(
                  hanXuLy: data[index].hanXuLy,
                  loaiNV: data[index].loaiNhiemVu,
                  ndTheoDoi: data[index].noiDungTheoDoi,
                  soNhiemVu: data[index].soNhiemVu,
                  tinhHinhThucHien: data[index].tinhHinhThucHienNoiBo,
                  trangThaiNhiemVu: data[index].trangThai,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => XemLuongXuLyNhiemVu(
                          id: data[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const SizedBox(
              height: 200,
              child: NodataWidget(),
            );
          }
        },
      );
}

class ItemKetLuanHopWidget extends StatelessWidget {
  final String title;
  final String time;
  final TrangThai trangThai;
  final TinhTrang tinhTrang;
  final Function onTap;
  final DetailMeetCalenderCubit cubit;
  final String id;
  final List<String> listFile;

  const ItemKetLuanHopWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.trangThai,
    required this.tinhTrang,
    required this.onTap,
    required this.cubit,
    required this.id,
    required this.listFile,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (cubit.isTaoMoiNhiemVu())
                        CellPopPupMenu(
                          urlImage: ImageAssets.icPlus2,
                          text: S.current.tao_moi_nhiem_vu,
                          onTap: () {
                            showBottomSheetCustom(
                              context,
                              title: S.current.tao_moi_nhiem_vu,
                              child: TaoMoiNhiemVuWidget(
                                cubit: cubit,
                              ),
                            );
                          },
                        ),
                      if (cubit.xemKetLuanHop())
                        CellPopPupMenu(
                          urlImage: ImageAssets.icDocument2,
                          text: S.current.ket_luan_cuoc_hop,
                          onTap: () {
                            xemOrTaoKetLuanHop(cubit, context);
                          },
                        ),
                      if (cubit.isGuiMailKetLuan())
                        CellPopPupMenu(
                          urlImage: ImageAssets.icMessage,
                          text: S.current.gui_mail_ket_luan,
                          onTap: () {
                            showDiaLog(
                              context,
                              textContent:
                                  S.current.ban_co_chac_chan_muon_gui_mai_nay,
                              btnLeftTxt: S.current.khong,
                              funcBtnRight: () async {
                                await cubit.sendMailKetLuatHop(id);
                              },
                              title: S.current.gui_email,
                              btnRightTxt: S.current.dong_y,
                              icon: SvgPicture.asset(ImageAssets.IcEmail),
                            );
                          },
                        ),
                      if (cubit.isThuHoi())
                        CellPopPupMenu(
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
                      if (cubit.isXoaKetLuanHop())
                        CellPopPupMenu(
                          urlImage: ImageAssets.icDeleteRed,
                          text: S.current.xoa,
                          onTap: () {
                            showDiaLog(
                              context,
                              textContent:
                                  S.current.ban_co_chac_chan_muon_xoa_klh_nay,
                              btnLeftTxt: S.current.khong,
                              funcBtnRight: () async {
                                await cubit
                                    .deleteKetLuanHop(
                                      cubit.xemKetLuanHopModel.id ?? '',
                                    )
                                    .then(
                                      (value) => cubit.getXemKetLuanHop(
                                        cubit.xemKetLuanHopModel.id ?? '',
                                      ),
                                    );
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
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listFile.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = listFile;
                return Text(
                  data[index],
                  style: textDetailHDSD(
                    fontSize: 14.0.textScale(),
                    color: color5A8DEE,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void xemOrTaoKetLuanHop(DetailMeetCalenderCubit cubit, BuildContext context) {
  if (isMobile()) {
    showBottomSheetCustom(
      context,
      title: S.current.ket_luan_cuoc_hop,
      child: XemKetLuanHopWidget(
        cubit: cubit,
      ),
    );
  } else {
    showDiaLogTablet(
      context,
      maxHeight: 280,
      title: S.current.thu_hoi_lich,
      child: XemKetLuanHopWidget(
        cubit: cubit,
      ),
      isBottomShow: false,
      funcBtnOk: () {
        Navigator.pop(context);
      },
    );
  }
}

class ItemDanhSachNhiemVu extends StatelessWidget {
  final String soNhiemVu;
  final String ndTheoDoi;
  final String tinhHinhThucHien;
  final String hanXuLy;
  final String loaiNV;
  final TrangThaiNhiemVu trangThaiNhiemVu;
  final Function ontap;

  const ItemDanhSachNhiemVu({
    Key? key,
    required this.soNhiemVu,
    required this.ndTheoDoi,
    required this.tinhHinhThucHien,
    required this.hanXuLy,
    required this.loaiNV,
    required this.trangThaiNhiemVu,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ontap();
                    },
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
                  hanXuLy,
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
                child: trangThaiNhiemVu.getWidgetTTNhiemVu(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
