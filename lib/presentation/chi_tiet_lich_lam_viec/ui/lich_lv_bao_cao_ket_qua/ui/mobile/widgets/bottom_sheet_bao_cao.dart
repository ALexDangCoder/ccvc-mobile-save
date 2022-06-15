import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';

class BaoCaoBottomSheet extends StatefulWidget {
  final List<BaoCaoModel> listBaoCao;
  const BaoCaoBottomSheet({Key? key, required this.listBaoCao})
      : super(key: key);

  @override
  _ChinhSuaBaoCaoBottomSheetState createState() =>
      _ChinhSuaBaoCaoBottomSheetState();
}

class _ChinhSuaBaoCaoBottomSheetState extends State<BaoCaoBottomSheet> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
      padding: const EdgeInsets.only(top: 20),
      child: FollowKeyBoardWidget(
        bottomWidget: DoubleButtonBottom(
          onPressed2: () {},
          title2: S.current.them,
          title1: S.current.dong,
          onPressed1: () {
            Navigator.pop(context);
          },
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
              CustomDropDown(
                value: S.current.trung_binh,
                items: widget.listBaoCao.map((e) => e.content).toList(),
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
                onChange: (List<File> files) {},
                files: const [],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
