
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/follow_key_broash.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class HinhThucHop extends StatefulWidget {
  const HinhThucHop({
    Key? key,
    required this.cubit,
    this.chiTietHop,
  }) : super(key: key);
  final TaoLichHopCubit cubit;
  final ChiTietLichHopModel? chiTietHop;

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
  void initState() {
    super.initState();
    if (widget.chiTietHop != null) {
      isHopTrucTiep = widget.chiTietHop!.diaDiemHop?.isNotEmpty ?? false;
      isHopTrucTuyen = widget.chiTietHop!.bit_HopTrucTuyen;
      isDuyetKyThuat = widget.chiTietHop!.isDuyetKyThuat ?? false;
      if(widget.chiTietHop!.bit_LinkTrongHeThong != null){
        kieuLinkHop = widget.chiTietHop!.bit_LinkTrongHeThong! ?  0 : 1;
      }
      widget.cubit.taoLichHopRequest.linkTrucTuyen =
      widget.chiTietHop!.linkTrucTuyen;
      widget.cubit.dsDiemCauSubject.sink.add(
        widget.chiTietHop!.dsDiemCau ?? [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TitleChildWidget(
      title: S.current.hinh_thuc_hop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerToggleWidget(
            showDivider: false,
            initData: isHopTrucTiep,
            title: S.current.hop_truc_tiep,
            onChange: (value) {
              isHopTrucTiep = value;
              widget.cubit.isHopTrucTiep = value;
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
              initValue: widget.chiTietHop?.diaDiemHop,
              urlIcon: ImageAssets.icLocation,
              hintText: S.current.dia_diem_hop,
              onChange: (value) {
                widget.cubit.taoLichHopRequest.diaDiemHop = value;
              },
              validate: (value){
                if(isHopTrucTiep){
                  if (value.trim().isEmpty) {
                    return '${S.current.vui_long_nhap} '
                        '${S.current.dia_diem_hop.toLowerCase()}';
                  }
                }
              },
            ),
          ],
          spaceH5,
          ContainerToggleWidget(
            initData: isHopTrucTuyen,
            title: S.current.hop_truc_tuyen,
            onChange: (value) {
              isHopTrucTuyen = value;
              if (value && isHopTrucTiep) {
                isHopTrucTiep = false;
                widget.cubit.isHopTrucTiep = false;
              }
              if(value && !isDuyetKyThuat){
                isDuyetKyThuat = true;
                widget.cubit.taoLichHopRequest.isDuyetKyThuat = true;
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
                    widget.cubit.taoLichHopRequest.bitLinkTrongHeThong =
                        value;
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
                  initValue: widget.chiTietHop?.linkTrucTuyen,
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
                    color: AppTheme.getInstance().colorField()
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
            StreamBuilder<List<DsDiemCau>>(
              stream: widget.cubit.dsDiemCauSubject,
              builder: (context, snapshot) {
                final listDiemCau = snapshot.data ?? [];
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView.builder(
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
                  ),
                );
              },
            ),
          ],
          if (!isHopTrucTuyen)
          spaceH20,
          TitleChildWidget(
            title: S.current.ky_thuat,
            child: ContainerToggleWidget(
              initData: isDuyetKyThuat,
              title: S.current.duyet_ky_thuat,
              onChange: (value) {
                isDuyetKyThuat = value;
                widget.cubit.taoLichHopRequest.isDuyetKyThuat = value;
              },
            ),
          ),
        ],
      ),
    );
  }




  void themDiemCauBTS() {
    final DsDiemCau diemCau = DsDiemCau();
    if(isMobile()) {
      showBottomSheetCustom(
      context,
      child: themDiemCau(diemCau),
      title: S.current.them_diem_cau,
    );
    }else{
      showDiaLogTablet(
        context,
        title: S.current.them_diem_cau,
        child: themDiemCau(diemCau),
        isBottomShow: false, funcBtnOk: () {  },
      );
    }
  }

  Widget themDiemCau(DsDiemCau diemCau){
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *0.8,
      ),
      child: FollowKeyBoardEdt(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                    _key.currentState?.validate();
                  },
                  validator: (value) {
                    return value.pleaseEnter(S.current.ten_don_vi);
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
                  maxLength: 255,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return null;
                    }
                    return value.trim().checkSdtRequire(
                          messageError: S.current.dinh_dang_sdt,
                        );
                  },
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
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
                  onClickLeft: () {
                    Navigator.pop(context);
                  },
                  onClickRight: () {
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
    );
  }

  Widget textField({
    required Function(String) onChange,
    String title = '',
    Function(String)? validator,
    bool isRequired = false,
    String hint = '',
    String? initValue,
    List<TextInputFormatter>? inputFormatter,
    TextInputType? keyboardType,
    int? maxLength,
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
            onChange(value.trim());
          },
          maxLength: maxLength,
          inputFormatters: inputFormatter,
          keyboardType: keyboardType,
          initialValue: initValue,
          decoration: InputDecoration(
            counterText: '',
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
                  value: (diemCau.tenDiemCau ?? '').trim(),
                  key: S.current.ten_don_vi,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(
                  value: (diemCau.canBoDauMoiHoTen ?? '').trim(),
                  key: S.current.can_bo_dau_moi,
                ),
                SizedBox(
                  height: 10.0.textScale(space: 10),
                ),
                rowInfo(
                  value: (diemCau.canBoDauMoiChucVu ?? '').trim(),
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
                  value: diemCau.getLoaiDiemCau,
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
