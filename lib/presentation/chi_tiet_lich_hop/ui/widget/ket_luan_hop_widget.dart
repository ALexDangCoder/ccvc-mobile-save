import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/file_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/xem_luong_xu_ly/xem_luong_xu_ly_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/extension_status.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/ket_luan_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_item_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_moi_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ketLuanHop(),
            textKetLuanHopNhiemVu(),
            listDanhSachNhiemVu()
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
          final data = snapshot.data ?? KetLuanHopModel();

          /// nêu không có cuộc họp trả về button soạn
          if ((data.title ?? '').isEmpty && widget.cubit.isSoanKetLuanHop()) {
            return IconWithTiltleWidget(
              icon: ImageAssets.icDocument2,
              title: S.current.soan_ket_luan_hop,
              onPress: () {
                xemOrTaoOrSuaKetLuanHop(
                  cubit: widget.cubit,
                  context: context,
                  title: S.current.soan_ket_luan_hop,
                  isCreate: true,
                  listFile: [],
                );
              },
            );

            /// nêu có cuộc họp trả về thông tin và các button khác
          } else if (widget.cubit.xemKetLuanHop()) {
            return Column(
              children: [
                ItemKetLuanHopWidget(
                  title: data.title ?? '',
                  time: data.thoiGian,
                  trangThai: data.trangThai,
                  tinhTrang: data.tinhTrang,
                  id: widget.cubit.idCuocHop,
                  cubit: widget.cubit,
                  listFile: data.file ?? [],
                ),
                /// các button khac
                if (!widget.cubit.isDuyetOrHuyKetLuanHop())
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        if (widget.cubit.isDuyetKL())
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ButtonOtherWidget(
                              text: S.current.duyet,
                              color: itemWidgetUsing,
                              ontap: () {
                                widget.cubit
                                    .xacNhanHoacHuyKetLuanHop(isDuyet: true);
                              },
                            ),
                          ),
                        if (widget.cubit.isTuCHoiKL())
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ButtonOtherWidget(
                              text: S.current.tu_choi,
                              color: statusCalenderRed,
                              ontap: () {
                                widget.cubit
                                    .xacNhanHoacHuyKetLuanHop(isDuyet: false);
                              },
                            ),
                          ),
                        if (widget.cubit.isGuiDuyet())
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ButtonOtherWidget(
                              text: S.current.gui_duyet,
                              color: color02C5DD,
                              ontap: () {
                                widget.cubit.guiDuyetKetLuanHop();
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
