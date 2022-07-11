import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file_lich_lam_viec.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DocumentFile extends StatefulWidget {
  final bool isTablet;
  final List<Files> files;
  final Function(List<File> file, bool validate) onChange;
  final Function(Files fileDelete) onDelete;

  const DocumentFile({
    Key? key,
    required this.files,
    required this.onChange,
    required this.onDelete,
    this.isTablet = false,
  }) : super(key: key);

  @override
  _DocumentFileState createState() => _DocumentFileState();
}

class _DocumentFileState extends State<DocumentFile> {
  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          S.current.tai_lieu,
          style: textNormalCustom(
            color: titleColumn,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonSelectFileLichLamViec(
            hasMultipleFile: true,
            maxSize: 20971520,
            title: S.current.dinh_kem_tep_english,
            onChange: (List<File> files, bool validate) {
              widget.onChange(files, validate);
            },
          ),
          spaceH16,
          if (widget.files.isNotEmpty)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.files.length,
              itemBuilder: (_, index) {
                return itemFile(widget.files[index], () {
                  widget.onDelete(widget.files[index]);
                });
              },
            ),
          if (widget.files.isEmpty)
            const SizedBox(
              height: 200,
              child: NodataWidget(),
            ),
        ],
      ),
    );
  }

  Widget itemFile(Files file, Function() onDelete) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: bgDropDown),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              file.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textNormalCustom(
                color: color5A8DEE,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: SvgPicture.asset(ImageAssets.icDelete),
          ),
        ],
      ),
    );
  }
}
