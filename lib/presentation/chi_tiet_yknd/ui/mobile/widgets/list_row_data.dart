import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/item_row.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ListItemRow extends StatelessWidget {
  final String title;
  final List<String>? content;
  final List<String>? nameFile;
  final List<String>? urlFile;
  final String? domainDownload;

  const ListItemRow({
    Key? key,
    required this.title,
    this.content,
    this.nameFile,
    this.urlFile,
    this.domainDownload,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content
                        ?.map(
                          (e) => InkWell(
                            onTap: isFile
                                ? () {
                                    final int index =
                                        (content ?? []).indexOf(e);
                                    saveFile(
                                      url: ('/') + (urlFile ?? [])[index],
                                      fileName: (nameFile ?? [])[index],
                                      downloadType: DomainDownloadType.PAKN,
                                    );
                                  }
                                : null,
                            child: Text(
                              e,
                              style: textNormalCustom(
                                fontSize: 14.0.textScale(),
                                fontWeight: FontWeight.w400,
                                color: isFile
                                    ? numberOfCalenders
                                    : titleCalenderWork,
                              ),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0.textScale(),
        ),
      ],
    );
  }
}
