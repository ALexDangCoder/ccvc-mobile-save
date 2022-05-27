import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

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
              flex: 2,
              child: Text(
                title,
                style: textNormalCustom(
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w400,
                  color: titleCalenderWork,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 6,
              child: Text(
                content ?? '',
                style: textNormalCustom(
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w400,
                  color: isFile ? numberOfCalenders : titleItemEdit,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

List<String> textColor = [
  S.current.tai_lieu_dinh_kem_cong_dan,
  S.current.file_dinh_kem
];
