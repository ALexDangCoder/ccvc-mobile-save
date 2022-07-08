import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/ket_luan_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/vb_giao_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html_editor_enhanced/utils/utils.dart';

import 'chon_ngay_widget.dart';
import 'dropdown_widget.dart';
import 'ket_luan_hop_widget.dart';

class TaoMoiNhiemVuWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const TaoMoiNhiemVuWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  State<TaoMoiNhiemVuWidget> createState() => _TaoMoiNhiemVuWidgetState();
}

class _TaoMoiNhiemVuWidgetState extends State<TaoMoiNhiemVuWidget> {
  final TextEditingController dvTheoDoiController = TextEditingController();
  final TextEditingController ngTheoDoiController = TextEditingController();
  final TextEditingController ndTheoDoiController = TextEditingController();
  final TextEditingController soKyHieuController = TextEditingController();
  final TextEditingController trichYeuController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();
  late ThemNhiemVuRequest themNhiemVuRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themNhiemVuRequest = ThemNhiemVuRequest();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.listVBGiaoNhiemVu.sink.add([]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FormGroup(
        key: keyGroup,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FollowKeyBoardWidget(
                bottomWidget: Row(
                  children: [
                    Expanded(
                      child: btnSuaLich(
                        name: S.current.dong,
                        bgr: buttonColor.withOpacity(0.1),
                        colorName: textDefault,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16.0.textScale(),
                    ),
                    Expanded(
                      child: btnSuaLich(
                        name: S.current.xac_nhan,
                        bgr: labelColor,
                        colorName: Colors.white,
                        onTap: () {
                          if (keyGroup.currentState!.validator()) {
                            widget.cubit.themNhiemVu(themNhiemVuRequest);
                          }
                        },
                      ),
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sb20(),

                      /// loai nhiem vu
                      StreamBuilder<List<DanhSachLoaiNhiemVuLichHopModel>>(
                        stream:
                            widget.cubit.danhSachLoaiNhiemVuLichHopModel.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return DropDownWidget(
                            isNote: true,
                            title: S.current.loai_nhiem_vu,
                            hint: S.current.loai_nhiem_vu,
                            listData: data.map((e) => e.ten ?? '').toList(),
                            onChange: (value) {
                              themNhiemVuRequest.processTypeId = data[value].id;
                            },
                          );
                        },
                      ),
                      sb20(),

                      /// don vi theo doi
                      ItemTextFieldWidget(
                        hint: S.current.don_vi_theo_doi,
                        title: S.current.don_vi_theo_doi,
                        controller: dvTheoDoiController,
                        validator: (String? value) {},
                        onChange: (String value) {

                        },
                      ),
                      sb20(),

                      /// nguoi theo doi
                      ItemTextFieldWidget(
                        hint: S.current.nguoi_theo_doi,
                        title: S.current.nguoi_theo_doi,
                        controller: ngTheoDoiController,
                        validator: (String? value) {},
                        onChange: (String value) {},
                      ),
                      sb20(),

                      /// boi dung
                      ItemTextFieldWidget(
                        hint: '',
                        title: S.current.noi_dung_theo_doi,
                        controller: ndTheoDoiController,
                        isRequired: true,
                        maxLine: 8,
                        validator: (String? value) {
                          return value?.checkNull();
                        },
                        onChange: (String value) {},
                      ),
                      sb20(),

                      /// hạn xu ly
                      PickDateWidget(
                        title: S.current.han_xu_ly,
                        minimumDate: DateTime.now(),
                        onChange: (DateTime value) {},
                      ),
                      sb20(),

                      /// người giao nhiem vu
                      StreamBuilder<List<NguoiChutriModel>>(
                        stream: widget.cubit.listNguoiCHuTriModel,
                        builder: (context, snapshot) {
                          final List<NguoiChutriModel> data =
                              snapshot.data ?? [];
                          return DropDownWidget(
                            title: S.current.nguoi_giao_nhiem_vu,
                            hint: S.current.nguoi_giao_nhiem_vu,
                            listData: data.map((e) => e.hoTen ?? '').toList(),
                            onChange: (value) {},
                          );
                        },
                      ),
                      sb20(),

                      /// van ban giao nhiem vu
                      btnWidget(
                        name: S.current.van_ban_giao_nhiem_vu,
                        onTap: () {
                          showBottomSheetCustom(
                            context,
                            title: S.current.van_ban_giao_nhiem_vu,
                            child: VBGiaoNhiemVu(
                              cubit: widget.cubit,
                              typeVB: 'lienquan',
                            ),
                          ).then((value) {
                            if (value == true) {
                              setState(mounted, (p0) {}, () {});
                            } else if (value == null) {
                              return;
                            }
                          });
                        },
                      ),
                      StreamBuilder<List<VBGiaoNhiemVuModel>>(
                        stream: widget.cubit.listVBGiaoNhiemVu.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data
                                  ?.where((element) =>
                                      element.hinhThucVanBan == 'lienquan')
                                  .toList() ??
                              [];
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ItemVbGIaoNhiemVuWidget(
                                cubit: widget.cubit,
                                soKyHieu: data[index].soVanBan ?? '',
                                ngayVB: DateTime.parse(data[index].ngayVanBan ??
                                        DateTime.now().toString())
                                    .toStringWithListFormat,
                                trichYeu: data[index].trichYeu ?? '',
                                listFile: [],
                                onTap: () {
                                  widget.cubit.vBGiaoNhiemVuModel
                                      .remove(data[index]);
                                  widget.cubit.listVBGiaoNhiemVu.sink
                                      .add(widget.cubit.vBGiaoNhiemVuModel);
                                },
                              );
                            },
                          );
                        },
                      ),
                      sb20(),

                      /// van ban khac
                      btnWidget(
                        name: S.current.van_ban_khac,
                        onTap: () {
                          showBottomSheetCustom(
                            context,
                            title: S.current.van_ban_khac,
                            child: VBGiaoNhiemVu(
                              cubit: widget.cubit,
                              typeVB: 'khac',
                            ),
                          );
                        },
                      ),
                      StreamBuilder<List<VBGiaoNhiemVuModel>>(
                          stream: widget.cubit.listVBGiaoNhiemVu.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data
                                    ?.where((element) =>
                                        element.hinhThucVanBan == 'khac')
                                    .toList() ??
                                [];
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return ItemVbGIaoNhiemVuWidget(
                                  cubit: widget.cubit,
                                  soKyHieu: data[index].soVanBan ?? '',
                                  ngayVB: DateTime.parse(
                                          data[index].ngayVanBan ??
                                              DateTime.now().toString())
                                      .toStringWithListFormat,
                                  trichYeu: data[index].trichYeu ?? '',
                                  listFile: [],
                                  onTap: () {
                                    widget.cubit.vBGiaoNhiemVuModel
                                        .remove(data[index]);
                                    widget.cubit.listVBGiaoNhiemVu.sink
                                        .add(widget.cubit.vBGiaoNhiemVuModel);
                                  },
                                );
                              },
                            );
                          }),
                      sb20(),
                    ],
                  ),
                ),
              ),
            ),
            sb20(),
          ],
        ),
      ),
    );
  }

  Widget sb20() {
    return SizedBox(
      height: 20.0.textScale(),
    );
  }
}

Widget btnWidget({required String name, required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.0.textScale(),
        vertical: 8.0.textScale(),
      ),
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(ImageAssets.icDocument2),
          SizedBox(
            width: 9.0.textScale(),
          ),
          Text(
            name,
            style: textNormalCustom(
              color: buttonColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.0.textScale(),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget btnSuaLich({
  required String name,
  required Color bgr,
  required Color colorName,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgr,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorName,
        ),
      ),
    ),
  );
}

class ItemVbGIaoNhiemVuWidget extends StatelessWidget {
  final String soKyHieu;
  final String ngayVB;
  final String trichYeu;
  final Function onTap;
  final DetailMeetCalenderCubit cubit;
  final List<String> listFile;

  const ItemVbGIaoNhiemVuWidget({
    Key? key,
    required this.soKyHieu,
    required this.ngayVB,
    required this.trichYeu,
    required this.onTap,
    required this.cubit,
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
          widgetRow(
            name: S.current.so_ky_hieu,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    soKyHieu,
                    style: textNormalCustom(
                      color: textTitle,
                      fontSize: 14.0.textScale(),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: SvgPicture.asset(ImageAssets.ic_delete_do),
                )
              ],
            ),
          ),
          widgetRow(
            name: S.current.ngay_van_ban,
            child: Text(
              ngayVB,
              style: textNormalCustom(
                color: textTitle,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          widgetRow(
            name: S.current.trich_yeu,
            child: Text(
              trichYeu,
              style: textNormalCustom(
                color: textTitle,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w400,
              ),
            ),
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
