import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:flutter/material.dart';

class BaoCaoDialogTablet extends StatefulWidget {
  final BaoCaoModel baoCaoModel;

  const BaoCaoDialogTablet({Key? key, required this.baoCaoModel})
      : super(key: key);

  @override
  _BaoCaoDialogTabletState createState() => _BaoCaoDialogTabletState();
}

class _BaoCaoDialogTabletState extends State<BaoCaoDialogTablet> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.current.trang_thai,
                  style: tokenDetailAmount(
                    fontSize: 14.0.textScale(),
                    color: titleItemEdit,
                  ),
                ),
                const Text(
                  ' *',
                  style: TextStyle(color: canceledColor),
                )
              ],
            ),
            SizedBox(
              height: 8.0.textScale(),
            ),
            CustomDropDown(
              value: widget.baoCaoModel.status.getText().text,
              items: [
                S.current.trung_binh,
                S.current.dat,
                S.current.khong_dat,
              ],
            ),
            SizedBox(
              height: 20.0.textScale(space: 4),
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
              // files: widget.baoCaoModel.listFile,
              title: S.current.tai_lieu_dinh_kem,
              onChange: (List<File> files) {},
              removeFileApi: (int index) {},
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
