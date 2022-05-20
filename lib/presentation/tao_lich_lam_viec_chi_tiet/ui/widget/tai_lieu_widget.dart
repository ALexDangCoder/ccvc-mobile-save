import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:flutter/material.dart';

class TaiLieuWidget extends StatefulWidget {
  const TaiLieuWidget({Key? key}) : super(key: key);

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              isExpand = !isExpand;
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.tai_lieu,
                  style: textNormalCustom(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0.textScale(),
                    color: color667793,
                  ),
                ),
                if (isExpand) const Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: colorA2AEBD,
                      ) else const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: colorA2AEBD,
                      )
              ],
            ),
          ),
          SizedBox(
            height: 16.5.textScale(),
          ),
          ExpandedSection(
            expand: isExpand,
            child: ButtonSelectFile(
              title: S.current.tai_lieu_dinh_kem,
              onChange: (List<File> files) {
                print(files);
              }, files: [],
            ),
          )
        ],
      ),
    );
  }
}
