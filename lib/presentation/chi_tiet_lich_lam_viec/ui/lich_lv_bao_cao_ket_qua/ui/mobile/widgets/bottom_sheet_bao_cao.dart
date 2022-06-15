import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaoCaoBottomSheet extends StatefulWidget {
  final List<TinhTrangBaoCaoModel> listTinhTrangBaoCao;
  final BaoCaoKetQuaCubit cubit;
  final String scheduleId;
  const BaoCaoBottomSheet(
      {Key? key,
      required this.listTinhTrangBaoCao,
      required this.cubit,
      required this.scheduleId})
      : super(key: key);

  @override
  _ChinhSuaBaoCaoBottomSheetState createState() =>
      _ChinhSuaBaoCaoBottomSheetState();
}

class _ChinhSuaBaoCaoBottomSheetState extends State<BaoCaoBottomSheet> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.init(widget.listTinhTrangBaoCao);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is SuccessChiTietLichLamViecState) {
          Navigator.pop(context);
        }
      },
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        padding: const EdgeInsets.only(top: 20),
        child: FollowKeyBoardWidget(
          bottomWidget: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DoubleButtonBottom(
                onPressed2: () {
                  widget.cubit
                      .createScheduleReport(widget.scheduleId, controller.text);
                },
                title2: S.current.them,
                title1: S.current.dong,
                onPressed1: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      S.current.trang_thai,
                      style: tokenDetailAmount(
                        fontSize: 14,
                        color: titleItemEdit,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(color: canceledColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CoolDropDown(
                  initData:
                      widget.cubit.tinhTrangBaoCaoModel?.displayName ?? '',
                  listData: widget.listTinhTrangBaoCao
                      .map((e) => e.displayName ?? '')
                      .toList(),
                  onChange: (index) {
                    widget.cubit.reportStatusId =
                        widget.listTinhTrangBaoCao[index].id ?? '';
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlockTextView(
                  title: S.current.noi_dung,
                  contentController: controller,
                  formKey: globalKey,
                  isRequired: false,
                ),
                const SizedBox(
                  height: 24,
                ),
                ButtonSelectFile(
                  title: S.current.tai_lieu_dinh_kem,
                  onChange: (files) {
                    widget.cubit.files = files;
                  },
                  files: widget.cubit.files,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
