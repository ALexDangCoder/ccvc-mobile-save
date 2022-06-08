import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/list_row_data.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ChiTietYKNDHeader extends StatefulWidget {
  final ChiTietYKienNguoiDanCubit cubit;

  const ChiTietYKNDHeader({Key? key, required this.cubit}) : super(key: key);

  @override
  _ChiTietYKNDHeaderState createState() => _ChiTietYKNDHeaderState();
}

class _ChiTietYKNDHeaderState extends State<ChiTietYKNDHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ListRowYKND>>(
      stream: widget.cubit.headerRowData,
      initialData: widget.cubit.listInitDataHeader,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListItemRow(
              title: data[index].title,
              content: data[index].content,
            );
          },
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
                  fontSize: 14.0.textScale(),
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
                  fontSize: 14.0.textScale(),
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
