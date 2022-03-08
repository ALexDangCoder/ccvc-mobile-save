import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/extension_status.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/item_menu_ket_thuc.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class KetLuanHopWidgetTablet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final String id;

  const KetLuanHopWidgetTablet(
      {Key? key, required this.id, required this.cubit})
      : super(key: key);

  @override
  _KetLuanHopWidgetTabletState createState() => _KetLuanHopWidgetTabletState();
}

class _KetLuanHopWidgetTabletState extends State<KetLuanHopWidgetTablet> {
  bool isShow = false;

  @override
  void initState() {
    widget.cubit.getXemKetLuanHop(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isShow) {
          isShow = false;
          setState(() {});
        }
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  StreamBuilder<KetLuanHopModel>(
                    stream: widget.cubit.ketLuanHopStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;

                        return ItemKetLuanHopWidgetTablet(
                          title: S.current.ket_luan_hop,
                          time: data?.thoiGian ?? '',
                          trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                          tinhTrang: data?.tinhTrang ?? TinhTrang.TrungBinh,
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
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    S.current.danh_sach_nhiem_vu,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0.textScale(),
                      color: dateColor,
                    ),
                  ),
                  StreamBuilder<DanhSachNhiemVuLichHopModel>(
                    stream: widget.cubit.streamDanhSachNhiemVuLichHop,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        return ItemDanhSachNhiemVuTablet(
                          hanXuLy: DateTime.parse(data?.hanXuLy ?? ''),
                          loaiNV: data?.loaiNhiemVu ?? '',
                          ndTheoDoi: data?.noiDungTheoDoi ?? '',
                          soNhiemVu: data?.soNhiemVu ?? '',
                          tinhHinhThucHien: data?.tinhHinhThucHienNoiBo ?? '',
                          trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                          index: 0,
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
            ),
            if (isShow)
              Column(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  Align(
                    alignment: const Alignment(0.85, 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 18.0.textScale(),
                        horizontal: 17.0.textScale(),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: listKetThucView
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return e.ketThuc.getScreen();
                                    },
                                  );
                                },
                                child: itemListKetThuc(
                                  name: e.name,
                                  icon: e.icon,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget itemListKetThuc({required String icon, required String name}) {
    return SizedBox(
      width: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: SvgPicture.asset(icon)),
          SizedBox(
            width: 10.0.textScale(),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: textNormalCustom(
                    color: textTitle,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
                SizedBox(
                  height: 14.0.textScale(),
                ),
                Container(
                  height: 1,
                  color: borderColor.withOpacity(0.5),
                ),
                SizedBox(
                  height: 14.0.textScale(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemKetLuanHopWidgetTablet extends StatelessWidget {
  final String title;
  final String time;
  final TrangThai trangThai;
  final TinhTrang tinhTrang;
  final Function onTap;

  const ItemKetLuanHopWidgetTablet({
    Key? key,
    required this.title,
    required this.time,
    required this.trangThai,
    required this.tinhTrang,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0.textScale()),
      padding: EdgeInsets.all(16.0.textScale()),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        border: Border.all(color: bgDropDown),
        borderRadius: BorderRadius.circular(12.0),
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
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: SvgPicture.asset(ImageAssets.ic_chitet),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
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
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      widgetRowTrangThai(
                        name: S.current.trang_thai,
                        child: trangThai.getWidget(),
                      ),
                      widgetRowTrangThai(
                        name: S.current.tinh_trang,
                        child: tinhTrang.getWidget(),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class ItemDanhSachNhiemVuTablet extends StatelessWidget {
  final String soNhiemVu;
  final String ndTheoDoi;
  final String tinhHinhThucHien;
  final DateTime hanXuLy;
  final String loaiNV;
  final TrangThai trangThai;
  final int index;

  const ItemDanhSachNhiemVuTablet({
    Key? key,
    required this.soNhiemVu,
    required this.ndTheoDoi,
    required this.tinhHinhThucHien,
    required this.hanXuLy,
    required this.loaiNV,
    required this.trangThai,
    required this.index,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  '${index.toString().padLeft(2, '0')}.',
                  style: textNormalCustom(
                    fontSize: 16.0,
                    color: titleItemEdit,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${S.current.loai_nhiem_vu}: $loaiNV',
                        style:
                            textNormalCustom(fontSize: 18.0, color: textTitle),
                      ),
                      GestureDetector(
                        onTap: () {
                          //  onTap();
                        },
                        child: SvgPicture.asset(ImageAssets.ic_baocao),
                      )
                    ],
                  ),
                  widgetRow(
                    name: S.current.so_nhiem_vu,
                    child: Text(
                      soNhiemVu,
                      style: textNormalCustom(
                        color: textTitle,
                        fontSize: 14.0.textScale(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: widgetRowTrangThai(
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
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            trangThai.getWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget widgetRowTrangThai({required String name, required Widget child}) {
  return Container(
    margin: EdgeInsets.only(top: 10.0.textScale()),
    child: Row(
      children: [
        Expanded(
          flex: 4,
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
