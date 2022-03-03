import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:flutter/material.dart';

class BaoCaoBottomSheet extends StatefulWidget {
  const BaoCaoBottomSheet({
    Key? key,
  }) : super(key: key);

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
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(top: 20),
      child: Scaffold(
        bottomNavigationBar: Column(
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                items: [
                  S.current.trung_binh,
                  S.current.dat,
                  S.current.khong_dat,
                ],
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

void showBaoCaoKetQua(BuildContext context) {
  showBottomSheetCustom(
    context,
    child: const BaoCaoBottomSheet(),
    title: S.current.bao_cao_ket_qua,
  );
}
