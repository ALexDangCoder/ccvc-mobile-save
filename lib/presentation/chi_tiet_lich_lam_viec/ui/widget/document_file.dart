
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class DocumentFile extends StatefulWidget {
  final bool isTablet;
  final List<Files> files;

  const DocumentFile({
    Key? key,
    required this.files,
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
          if (widget.files.isNotEmpty)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.files.length,
              itemBuilder: (_, index) {
                return itemFile(widget.files[index]);
              },
            ),
          if (widget.files.isEmpty)
            const SizedBox(
              height: 150,
              child: NodataWidget(),
            ),
        ],
      ),
    );
  }

  Widget itemFile(Files file) {
    return GestureDetector(
      onTap: () async {
        await saveFile(
          fileName: file.name  ?? '',
          url: file.path ?? '',
          downloadType: DomainDownloadType.QLNV,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
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
          ],
        ),
      ),
    );
  }
}
