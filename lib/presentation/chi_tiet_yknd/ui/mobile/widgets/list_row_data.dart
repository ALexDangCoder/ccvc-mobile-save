import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/item_row.dart';
import 'package:flutter/material.dart';

class ListItemRow extends StatelessWidget {
  final String title;
  final List<String>? content;

  const ListItemRow({
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content?.map((e) =>
                    Text(
                      e,
                      style: textNormalCustom(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isFile ? numberOfCalenders : titleCalenderWork,
                      ),
                    ),
                ).toList()??[],
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