import 'dart:async';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:flutter/material.dart';

class YKienBottomSheet extends StatefulWidget {
  final String id;
  final bool isCheck;
  final bool isTablet;
  final bool isCalendarWork;

  const YKienBottomSheet(
      {Key? key,
      this.isTablet = false,
      required this.id,
      this.isCheck = true,
      this.isCalendarWork = false})
      : super(key: key);

  @override
  _ChinhSuaBaoCaoBottomSheetState createState() =>
      _ChinhSuaBaoCaoBottomSheetState();
}

class _ChinhSuaBaoCaoBottomSheetState extends State<YKienBottomSheet> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  final ChiTietLichLamViecCubit chiTietLichLamViecCubit =
      ChiTietLichLamViecCubit();

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlockTextView(
                title: widget.isCalendarWork
                    ? S.current.content
                    : S.current.y_kien_cuop_hop,
                contentController: controller,
                formKey: globalKey,
                isRequired: false,
              ),
              spaceH24,
              Center(
                child: SizedBox(
                  height: 44,
                  width: widget.isTablet ? 300 : double.infinity,
                  child: DoubleButtonBottom(
                    onClickRight: () async {
                      await chiTietLichLamViecCubit
                          .themYKien(
                        content: controller.text,
                        phienHopId: null,
                        scheduleId: widget.id,
                        scheduleOpinionId: null,
                      )
                          .then((value) {
                        MessageConfig.show(
                          title: S.current.cho_y_kien_thanh_cong,
                        );
                      }).onError((error, stackTrace) {
                        MessageConfig.show(
                          title: S.current.cho_y_kien_that_bai,
                          messState: MessState.error,
                        );
                      });
                      Navigator.pop(context, true);
                    },
                    title2: S.current.them,
                    title1: S.current.dong,
                    onClickLeft: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              spaceH24,
            ],
          ),
        ),
      ),
    );
  }
}
