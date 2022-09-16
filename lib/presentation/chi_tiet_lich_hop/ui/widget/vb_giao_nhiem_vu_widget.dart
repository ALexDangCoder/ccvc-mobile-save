import 'dart:io';

import 'package:ccvc_mobile/bao_cao_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'chon_ngay_widget.dart';

const List<String> FILE_ALLOW = [
  'xlsx',
  'xlsm',
  'pptm',
  'pptx',
  'dotx',
  'docx',
  'pdf',
  'png',
  'jpg',
  'jpeg',
  'doc'
];

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
  final selectFileKey = GlobalKey<SelectFileBtnState>();

  late VBGiaoNhiemVuModel vBGiaoNhiemVuModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vBGiaoNhiemVuModel = VBGiaoNhiemVuModel();
    vBGiaoNhiemVuModel.ngayVanBan = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    vBGiaoNhiemVuModel.hinhThucVanBan = widget.typeVB;
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.luu,
          onPressed1: () {
            Navigator.pop(context);
          },
          onPressed2: () {
            final List<VBGiaoNhiemVuModel> list =
                widget.cubit.listVBGiaoNhiemVu.valueOrNull ?? [];
            list.add(vBGiaoNhiemVuModel);
            widget.cubit.listVBGiaoNhiemVu.sink.add(list);
            Navigator.pop(context, true);
          },
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
          PickDateWidget(
            checkRequire: false,
            title: S.current.ngay_van_ban,
            onChange: (value) {
              vBGiaoNhiemVuModel.ngayVanBan = value.toString();
            },
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
          SelectFileBtn(
            key: selectFileKey,
            allowedExtensions: FILE_ALLOW,
            hasMultiFile: false,
            replaceFile: true,
            onChange: (List<File> fileSelected) {
              if(fileSelected.isEmpty){
                vBGiaoNhiemVuModel.file=[];
              }
              if (fileSelected.isNotEmpty) {
                widget.cubit.uploadFile(fileSelected).then((value) {
                  value.when(
                    success: (res) {
                      vBGiaoNhiemVuModel.file = res;
                    },
                    error: (_) {
                      selectFileKey.currentState?.clearData();
                      MessageConfig.show(
                        title: S.current.chon_file_that_bai,
                        messState: MessState.error,
                      );
                    },
                  );
                });
              }
            },
          ),
          SizedBox(
            height: 20.0.textScale(),
          )
        ],
      ),
    );
  }

  void showToast(String title) {
    final toast = FToast();
    toast.init(context);
    toast.showToast(
      child: ShowToast(
        text: title,
      ),
      gravity: ToastGravity.BOTTOM,
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
