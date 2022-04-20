import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/xem_ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/material.dart';

import 'chon_ngay_widget.dart';

class VBGiaoNhiemVu extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final String typeVB;

  const VBGiaoNhiemVu({
    Key? key,
    required this.cubit,
    required this.typeVB,
  }) : super(key: key);

  @override
  State<VBGiaoNhiemVu> createState() => _VBGiaoNhiemVuState();
}

class _VBGiaoNhiemVuState extends State<VBGiaoNhiemVu> {
  TextEditingController soKyHieuController = TextEditingController();
  TextEditingController trichYeuController = TextEditingController();

  late VBGiaoNhiemVuModel vBGiaoNhiemVuModel;
  bool ngayBatBuoc = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vBGiaoNhiemVuModel = VBGiaoNhiemVuModel.emty();
  }

  @override
  Widget build(BuildContext context) {
    vBGiaoNhiemVuModel.hinhThucVanBan = widget.typeVB;
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
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
                name: S.current.luu,
                bgr: labelColor,
                colorName: Colors.white,
                onTap: () {
                  if (vBGiaoNhiemVuModel.ngayVanBan == null) {
                    ngayBatBuoc = true;
                    setState(() {});
                  } else {
                    widget.cubit.vBGiaoNhiemVuModel.add(vBGiaoNhiemVuModel);
                    widget.cubit.listVBGiaoNhiemVu.sink
                        .add(widget.cubit.vBGiaoNhiemVuModel);
                    Navigator.pop(context, true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sb20(),
          ItemTextFieldWidget(
            title: S.current.so_ky_hieu,
            hint: S.current.so_ky_hieu,
            controller: soKyHieuController,
            onChange: (value) {
              vBGiaoNhiemVuModel.soVanBan = value;
            },
            validator: (value) {},
          ),
          sb20(),
          ShowRequied(
            textShow: 'Chưa chọn ngày tháng',
            isShow: ngayBatBuoc,
            child: PickDateWidget(
              title: S.current.ngay_van_ban,
              onChange: (value) {
                vBGiaoNhiemVuModel.ngayVanBan = value.toString();
              },
            ),
          ),
          sb20(),
          ItemTextFieldWidget(
            title: S.current.trich_yeu,
            hint: S.current.trich_yeu,
            controller: trichYeuController,
            onChange: (value) {
              vBGiaoNhiemVuModel.trichYeu = value;
            },
            validator: (value) {},
          ),
          sb20(),
          ButtonSelectFile(
            title: S.current.tai_lieu_dinh_kem,
            onChange: (List<File> files) {
              print(files);
            },
            files: [],
          ),
          SizedBox(
            height: 20.0.textScale(),
          )
        ],
      ),
    );
  }

  Widget sb20() {
    return SizedBox(
      height: 20.0.textScale(),
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
}
