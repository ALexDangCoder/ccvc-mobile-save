import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/ket_luan_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/vb_giao_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/double_button_bottom.dart';
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
import 'package:path/path.dart';

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
  late String ngGiaoNvId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ngGiaoNvId = '';
    themNhiemVuRequest = ThemNhiemVuRequest(
      idCuocHop: widget.cubit.idCuocHop,
      hanXuLy: DateTime.now().toStringWithListFormat,
      processTypeId:
          (widget.cubit.danhSachLoaiNhiemVuLichHopModel.valueOrNull ?? [])
              .first
              .id,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.listVBGiaoNhiemVu.sink.add([]);
    themNhiemVuRequest = ThemNhiemVuRequest();
    ngGiaoNvId = '';
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
                bottomWidget: DoubleButtonBottom(
                  title1: S.current.dong,
                  title2: S.current.xac_nhan,
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onPressed2: () {
                    if (keyGroup.currentState!.validator()) {
                      themNhiemVuRequest.meTaDaTa = [
                        MeTaDaTaRequest(
                          key: 'NguoiGiaoId',
                          value: ngGiaoNvId,
                        ),
                        MeTaDaTaRequest(
                          key: 'DonViTheoDoi',
                          value: ngTheoDoiController.text,
                        ),
                        MeTaDaTaRequest(
                          key: 'NguoiTheoDoi',
                          value: ngTheoDoiController.text,
                        )
                      ];
                      widget.cubit.themNhiemVu(themNhiemVuRequest);
                      Navigator.pop(context);
                    }
                  },
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
                        onChange: (String value) {},
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
                        onChange: (String value) {
                          themNhiemVuRequest.processContent = value;
                        },
                      ),
                      sb20(),

                      /// hạn xu ly
                      PickDateWidget(
                        title: S.current.han_xu_ly,
                        minimumDate: DateTime.now(),
                        onChange: (DateTime value) {
                          themNhiemVuRequest.hanXuLy =
                              value.toStringWithListFormat;
                        },
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
                            onChange: (value) {
                              ngGiaoNvId = data[value].id ?? '';
                            },
                          );
                        },
                      ),
                      sb20(),

                      /// van ban giao nhiem vu
                      buttonThemVb(
                        loaiVbThem: 'lienquan',
                        title: S.current.van_ban_giao_nhiem_vu,
                        context: context,
                      ),

                      /// van ban khac
                      buttonThemVb(
                        loaiVbThem: 'khac',
                        title: S.current.van_ban_khac,
                        context: context,
                      ),
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

  Widget buttonThemVb({
    required String loaiVbThem,
    required String title,
    required BuildContext context,
  }) =>
      Column(
        children: [
          IconWithTiltleWidget(
            title: title,
            icon: ImageAssets.icDocument2,
            onPress: () {
              showBottomSheetCustom(
                context,
                title: title,
                child: VBGiaoNhiemVu(
                  cubit: widget.cubit,
                  typeVB: loaiVbThem,
                ),
              );
            },
          ),
          StreamBuilder<List<VBGiaoNhiemVuModel>>(
              stream: widget.cubit.listVBGiaoNhiemVu.stream,
              builder: (context, snapshot) {
                final data = snapshot.data
                        ?.where(
                            (element) => element.hinhThucVanBan == loaiVbThem)
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
                        data[index].ngayVanBan ?? DateTime.now().toString(),
                      ).toStringWithListFormat,
                      trichYeu: data[index].trichYeu ?? '',
                      file: data[index].file?.first ?? '',
                      onTap: () {
                        onTapRemoveVb(
                          cubit: widget.cubit,
                          data: data[index],
                        );
                      },
                    );
                  },
                );
              }),
        ],
      );

  Widget sb20() {
    return SizedBox(
      height: 20.0.textScale(),
    );
  }

  void onTapRemoveVb({
    required DetailMeetCalenderCubit cubit,
    required VBGiaoNhiemVuModel data,
  }) {
    final List<VBGiaoNhiemVuModel> list =
        cubit.listVBGiaoNhiemVu.valueOrNull ?? [];
    list.remove(data);
    cubit.listVBGiaoNhiemVu.sink.add(list);
  }
}

class ItemVbGIaoNhiemVuWidget extends StatelessWidget {
  final String soKyHieu;
  final String ngayVB;
  final String trichYeu;
  final Function onTap;
  final DetailMeetCalenderCubit cubit;
  final String file;

  const ItemVbGIaoNhiemVuWidget({
    Key? key,
    required this.soKyHieu,
    required this.ngayVB,
    required this.trichYeu,
    required this.onTap,
    required this.cubit,
    required this.file,
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
            child: Text(
              file,
              style: textDetailHDSD(
                fontSize: 14.0.textScale(),
                color: color5A8DEE,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
