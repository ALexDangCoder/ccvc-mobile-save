import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/item_row.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemRow extends StatelessWidget {
  final String title;
  final List<String>? content;
  final List<String>? nameFile;
  final List<String>? urlFile;
  const ListItemRow({
    Key? key,
    required this.title,
    this.content,
    this.nameFile,
    this.urlFile,
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
                            onTap: isFile ? () {
                              int index = (content ?? []).indexOf(e);
                              handleSaveFile(url: '${Get.find<AppConstants>().baseUrlPAKN}${(urlFile ?? [])[index]}', name: (nameFile ?? [])[index]);
                            } : null,
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
