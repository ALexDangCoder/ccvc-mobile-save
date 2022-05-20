import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lich_lv_bao_cao_ket_qua/bloc/bao_cao_ket_qua_bloc.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChinhSuaBaoCaoBottomSheet extends StatefulWidget {
  final BaoCaoModel baoCaoModel;
  final ChiTietLichLamViecCubit cubit;
  const ChinhSuaBaoCaoBottomSheet(
      {Key? key, required this.baoCaoModel, required this.cubit})
      : super(key: key);

  @override
  _ChinhSuaBaoCaoBottomSheetState createState() =>
      _ChinhSuaBaoCaoBottomSheetState();
}

class _ChinhSuaBaoCaoBottomSheetState extends State<ChinhSuaBaoCaoBottomSheet> {
  late TextEditingController controller;
  GlobalKey<FormState> globalKey = GlobalKey();
  final BaoCaoKetQuaCubit cubit = BaoCaoKetQuaCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getFile(widget.baoCaoModel.listFile);
    controller = TextEditingController(text: widget.baoCaoModel.content);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: const EdgeInsets.only(top: 20),
      child: FollowKeyBoardWidget(
        bottomWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonCustomBottom(
                    title: S.current.dong,
                    isColorBlue: false,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ButtonCustomBottom(
                    title: S.current.sua,
                    isColorBlue: true,
                    onPressed: () {
                      widget.cubit.updateBaoCaoKetQua(
                        reportStatusId: cubit.idReport,
                        id: widget.baoCaoModel.id,
                        scheduleId: widget.cubit.idLichLamViec,
                        files: cubit.filesLocal,
                        filesDelete: cubit.listFileRemove
                            .map((e) => e.id ?? '')
                            .toList(),
                        content: controller.text,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    S.current.trang_thai,
                    style: tokenDetailAmount(
                      fontSize: 14,
                      color: color586B8B,
                    ),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(color: colorF94444),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomDropDown(
                value: widget.baoCaoModel.status.getText().text,
                items: widget.cubit.listTinhTrang
                    .map((e) => e.displayName ?? '')
                    .toList(),
                onSelectItem: (value) {

                  cubit
                      .selectReport(widget.cubit.listTinhTrang[value].id ?? '');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlockTextView(
                title: S.current.noi_dung,
                contentController: controller,
                formKey: globalKey,
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonSelectFile(
                title: S.current.tai_lieu_dinh_kem,
                onChange: (files) {
                  cubit.addFilesLocal(files);
                },
                builder: (context, _) => const SizedBox(),
              ),
              StreamBuilder<List<FileModel>>(
                stream: cubit.getFileApi,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <FileModel>[];
                  return Column(
                    children: data
                        .map(
                          (e) => itemListFile(
                            name: e.name ?? '',
                            onTap: () {
                              cubit.removeFileApi(e);
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              StreamBuilder<List<File>>(
                stream: cubit.addFile,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <File>[];
                  return Column(
                    children: data
                        .map(
                          (e) => itemListFile(
                            name: e.path.convertNameFile(),
                            onTap: () {
                              cubit.removeFileLocal(e);
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemListFile({
    required String name,
    required Function onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 16.0.textScale()),
      padding: EdgeInsets.all(16.0.textScale()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0.textScale()),
        border: Border.all(color: colorE2E8F0),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: textNormalCustom(
                color: color5A8DEE,
                fontWeight: FontWeight.w400,
                fontSize: 14.0.textScale(),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: SvgPicture.asset(ImageAssets.icDelete),
          ),
        ],
      ),
    );
  }
}
