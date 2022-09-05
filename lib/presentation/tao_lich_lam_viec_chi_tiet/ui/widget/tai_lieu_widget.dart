import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file_lich_lam_viec.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:flutter/material.dart';

class TaiLieuWidget extends StatefulWidget {
  List<Files>? files;
  final Function(List<File>, bool) onChange;
  Function(String id) idRemove;
  final Function(int index)? getIndex;
  final bool isHaveExpanded;
  String size;
  final bool isTitle;

  TaiLieuWidget({
    Key? key,
    this.files,
    required this.onChange,
    required this.idRemove,
    this.size = '',
    this.isHaveExpanded = false,
    this.getIndex,
    this.isTitle = true,
  }) : super(key: key);

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  bool isExpand = false;
  double maxSize20MB = 20971520;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isHaveExpanded)
          widget.isTitle
              ? Text(
                  S.current.tai_lieu,
                  style: textNormalCustom(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0.textScale(),
                    color: color667793,
                  ),
                )
              : Container()
        else
          GestureDetector(
            onTap: () {
              isExpand = !isExpand;
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.isTitle)
                  Text(
                    S.current.tai_lieu,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.textScale(),
                      color: color667793,
                    ),
                  )
                else
                  Container(),
                if (isExpand)
                  const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: AqiColor,
                  )
                else
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AqiColor,
                  )
              ],
            ),
          ),
        SizedBox(
          height: 16.5.textScale(),
        ),
        ExpandedSection(
          expand: (widget.isHaveExpanded) ? true : isExpand,
          child: ButtonSelectFileLichLamViec(
            hasMultipleFile: true,
            maxSize: maxSize20MB,
            files: widget.files,
            title: S.current.tai_lieu_dinh_kem,
            onChange: (List<File> files, bool validate) {
              widget.onChange(files, validate);
            },
            getIndexFunc: widget.getIndex,
            allowedExtensions: const [
              FileExtensions.DOC,
              FileExtensions.DOCX,
              FileExtensions.JPEG,
              FileExtensions.JPG,
              FileExtensions.PDF,
              FileExtensions.PNG,
              FileExtensions.XLSX,
            ],
            errOverSizeMessage: S.current.dung_luong_toi_da_20,
          ),
        )
      ],
    );
  }
}
