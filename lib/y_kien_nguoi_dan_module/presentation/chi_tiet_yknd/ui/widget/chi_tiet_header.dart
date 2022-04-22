
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/config/resources/color.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:flutter/material.dart';

class ChiTietYKNDHeader extends StatefulWidget {
  final List<DataRowChiTietKienNghi> listRow;

  const ChiTietYKNDHeader({Key? key, required this.listRow}) : super(key: key);

  @override
  _ChiTietYKNDHeaderState createState() => _ChiTietYKNDHeaderState();
}

class _ChiTietYKNDHeaderState extends State<ChiTietYKNDHeader> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.listRow.length,
      itemBuilder: (context, index) {
        return ItemRow(
          title: widget.listRow[index].title,
          content: widget.listRow[index].content,
        );
      },
    );
  }
}

class ItemRow extends StatelessWidget {
  final String title;
  final String? content;
  const ItemRow({
    Key? key,
    required this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isFile;
    textColor.contains(title) ? isFile = true : isFile = false;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: textNormalCustom(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: infoColor,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 7,
              child: Text(
                content ?? '',
                style: textNormalCustom(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isFile ? numberOfCalenders : titleCalenderWork,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

List<String> textColor = [
  S.current.tai_lieu_dinh_kem_cong_dan,
  S.current.file_dinh_kem
];
