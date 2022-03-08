import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/extension_status.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'item_menu_ket_thuc.dart';

class KetLuanHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final String id;


  KetLuanHopWidget({Key? key, required this.cubit,required this.id}) : super(key: key);

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
    return SelectOnlyWidget(
      title: S.current.ket_luan_hop,
      child: GestureDetector(
        onTap: () {
          if (isShow) {
            isShow = false;
            setState(() {});
          }
        },
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
            if (isShow)
              Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: const Alignment(0.5, 0.5),
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
            else
              Container()
          ],
        ),
      ),
    );
  }

  Widget itemListKetThuc({required String icon, required String name}) {
    return Container(
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

class ItemKetLuanHopWidget extends StatelessWidget {
  final String title;
  final String time;
  final TrangThai trangThai;
  final TinhTrang tinhTrang;
  final Function onTap;

  const ItemKetLuanHopWidget({
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
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: SvgPicture.asset(ImageAssets.ic_baocao),
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
                    child: SvgPicture.asset(ImageAssets.ic_chitet),
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
