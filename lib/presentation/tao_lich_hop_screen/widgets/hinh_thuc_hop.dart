
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HinhThucHop extends StatefulWidget {
  const HinhThucHop({Key? key, required this.cubit}) : super(key: key);
  final TaoLichHopCubit cubit;

  @override
  _HinhThucHopState createState() => _HinhThucHopState();
}

class _HinhThucHopState extends State<HinhThucHop> {
  bool isHopTrucTiep = false;
  bool isHopTrucTuyen = false;
  bool isDuyetKyThuat = false;

  /// -1 : bỏ qua
  ///  0 : link trong hệ thống
  ///  1 : ngoài hệ thống
  int kieuLinkHop = -1;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TitleChildWidget(
      title: S.current.hinh_thuc_hop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerToggleWidget(
            key: UniqueKey(),
            showDivider: false,
            initData: isHopTrucTiep,
            title: S.current.hop_truc_tiep,
            onChange: (value) {
              isHopTrucTiep = value;
              if (value && isHopTrucTuyen) {
                isHopTrucTuyen = false;
              }
              widget.cubit.taoLichHopRequest.bitHopTrucTuyen = isHopTrucTuyen;
              setState(() {});
            },
          ),
          if (!isHopTrucTiep)
            const Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Divider(
                color: colorECEEF7,
                thickness: 1,
              ),
            ),
          if (isHopTrucTiep) ...[
            TextFieldStyle(
              urlIcon: ImageAssets.icLocation,
              hintText: S.current.dia_diem_hop,
              onChange: (value) {
                widget.cubit.taoLichHopRequest.diaDiemHop = value;
              },
            ),
          ],
          spaceH5,
          ContainerToggleWidget(
            key: UniqueKey(),
            initData: isHopTrucTuyen,
            title: S.current.hop_truc_tuyen,
            onChange: (value) {
              isHopTrucTuyen = value;
              if (value && isHopTrucTiep) {
                isHopTrucTiep = false;
              }
              if(value && !isDuyetKyThuat){
                isDuyetKyThuat = true;
                widget.cubit.taoLichHopRequest.bitYeuCauDuyet = true;
              }
              widget.cubit.taoLichHopRequest.bitHopTrucTuyen = value;
              setState(() {});
            },
          ),
          if (isHopTrucTuyen) ...[
            spaceH20,
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: SolidButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ThemLinkHopDialog(),
                  ).then((value) {
                    if (value == null) {
                      return;
                    }
                    if (value) {
                      widget.cubit.taoLichHopRequest.linkTrucTuyen =
                          widget.cubit.genLinkHop();
                      kieuLinkHop = 0;
                    } else {
                      widget.cubit.taoLichHopRequest.linkTrucTuyen = '';
                      kieuLinkHop = 1;
                    }
                    setState(() {});
                  });
                },
                text: S.current.them_link_hop,
                urlIcon: ImageAssets.icAddButtonCalenderTablet,
              ),
            ),
            if (kieuLinkHop == 1) ...[
              spaceH16,
              Padding(
                padding: const EdgeInsets.only(
                  left: 28.0,
                ),
                child: textField(
                  title: S.current.link_ngoai_he_thong,
                  onChange: (value) {
                    widget.cubit.taoLichHopRequest.linkTrucTuyen = value;
                  },
                  hint: S.current.nhap_link_ngoai_ht,
                ),
              )
            ],
            if (kieuLinkHop == 0)
              Padding(
                padding: const EdgeInsets.only(
                  left: 28.0,
                  top: 16,
                ),
                child: Text(
                  widget.cubit.taoLichHopRequest.linkTrucTuyen ?? '',
                  style: textNormal(textDefault, 14).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            spaceH16,
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: SolidButton(
                onTap: () {
                  themDiemCauBTS();
                },
                text: S.current.them_diem_cau,
                urlIcon: ImageAssets.icAddButtonCalenderTablet,
              ),
            ),
            spaceH20,
            StreamBuilder<List<DsDiemCau>>(
              stream: widget.cubit.dsDiemCauSubject,
              builder: (context, snapshot) {
                final listDiemCau = snapshot.data ?? [];
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listDiemCau.length,
                  itemBuilder: (context, index) => ItemDiemCau(
                    diemCau: listDiemCau[index],
                    onDeleteClick: () {
                      listDiemCau.removeAt(index);
                      widget.cubit.dsDiemCauSubject.add(listDiemCau);
                    },
                  ),
                );
              },
            ),
          ],
          spaceH24,
          TitleChildWidget(
            title: S.current.ky_thuat,
            child: ContainerToggleWidget(
              key: UniqueKey(),
              initData: isDuyetKyThuat,
              title: S.current.duyet_ky_thuat,
              onChange: (value) {
                widget.cubit.taoLichHopRequest.bitYeuCauDuyet = value;
              },
            ),
          ),
          spaceH24,
        ],
      ),
    );
  }




  void themDiemCauBTS() {
    final DsDiemCau diemCau = DsDiemCau();
    showBottomSheetCustom(
      context,
      child: FollowKeyBoardWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH20,
                textField(
                  onChange: (value) {
                    diemCau.tenDiemCau = value;
                  },
                  validator: (value) {
                    return value.isEmpty ? S.current.khong_duoc_de_trong : null;
                  },
                  isRequired: true,
                  title: S.current.ten_don_vi,
                  hint: S.current.ten_don_vi,
                ),
                spaceH20,
                textField(
                  onChange: (value) {
                    diemCau.canBoDauMoiHoTen = value;
                  },
                  validator: (value) {},
                  title: S.current.can_bo_dau_moi,
                  hint: S.current.can_bo_dau_moi,
                ),
                spaceH20,
                textField(
                  onChange: (value) {
                    diemCau.canBoDauMoiChucVu = value;
                  },
                  validator: (value) {},
                  title: S.current.chuc_vu,
                  hint: S.current.chuc_vu,
                ),
                spaceH20,
                textField(
                  onChange: (value) {
                    diemCau.canBoDauMoiSDT = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return null;
                    }
                    final phoneRegex = RegExp(VN_PHONE);
                    final bool checkRegex = phoneRegex.hasMatch(value);
                    return checkRegex ? null : S.current.nhap_sai_dinh_dang;
                  },
                  title: S.current.so_dien_thoai,
                  hint: S.current.so_dien_thoai,
                ),
                spaceH20,
                CoolDropDown(
                  onChange: (index) {
                    /// điểm chính = 1
                    /// điểm phụ = 2
                    /// => điểm cầu = index +1
                    diemCau.loaiDiemCau = index + 1;
                  },
                  listData: [
                    S.current.diem_chinh,
                    S.current.diem_phu,
                  ],
                  initData: S.current.diem_chinh,
                ),
                spaceH20,
                DoubleButtonBottom(
                  title1: S.current.dong,
                  title2: S.current.xac_nhan,
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onPressed2: () {
                    if (_key.currentState?.validate() ?? false) {
                      final dsDiemCau = widget.cubit.dsDiemCauSubject.value;
                      diemCau.loaiDiemCau ??= 1;
                      dsDiemCau.add(diemCau);
                      widget.cubit.dsDiemCauSubject.add(dsDiemCau);
                      MessageConfig.show(
                        title: S.current.thay_doi_thanh_cong,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
                spaceH30,
              ],
            ),
          ),
        ),
      ),
      title: S.current.them_diem_cau,
    );
  }

  Widget textField({
    required Function(String) onChange,
    String title = '',
    Function(String)? validator,
    bool isRequired = false,
    String hint = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Row(
            children: [
              Text(
                title,
                style: textNormal(titleColumn, 14),
              ),
              if (isRequired)
                const Text(
                  '*',
                  style: TextStyle(
                    color: statusCalenderRed,
                  ),
                )
            ],
          ),
          spaceH8,
        ],
        TextFormField(
          style: textNormal(color3D5586, 14.0.textScale()),
          onChanged: (value) {
            onChange(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            hintText: hint,
            hintStyle: textNormal(textBodyTime, 14.0.textScale()),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: borderButtomColor),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderButtomColor),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderButtomColor),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderButtomColor),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderButtomColor),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
          validator: (value) {
            return validator?.call(value ?? '');
          },
        ),
      ],
    );
  }
}

class ItemDiemCau extends StatelessWidget {
  const ItemDiemCau({
    Key? key,
    required this.diemCau,
    required this.onDeleteClick,
  }) : super(key: key);
  final DsDiemCau diemCau;
  final Function() onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child: Column(
              children: [
                rowInfo(
                  value: diemCau.tenDiemCau ?? '',
                  key: S.current.ten_don_vi,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(
                  value: diemCau.canBoDauMoiHoTen ?? '',
                  key: S.current.can_bo_dau_moi,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(
                  value: diemCau.canBoDauMoiChucVu ?? '',
                  key: S.current.chuc_vu,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(
                  value: diemCau.canBoDauMoiSDT ?? '',
                  key: S.current.so_dien_thoai,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(
                  value: diemCau.getLoaiDiemCau(),
                  key: S.current.diem_cau_chinh_phu,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                onDeleteClick();
              },
              child: SvgPicture.asset(ImageAssets.icDeleteRed),
            ),
          )
        ],
      ),
    );
  }
}
