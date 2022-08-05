import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaoCaoItem extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String content;
  final List<FileModel> files;
  final Function() funcEdit;
  final Function() funcDelete;
  final bool isShowEdit;
  final bool isShowDelete;

  const BaoCaoItem({
    Key? key,
    required this.status,
    required this.content,
    required this.funcEdit,
    required this.funcDelete,
    required this.statusColor,
    required this.files,
    this.isShowEdit = false,
    this.isShowDelete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: bgDropDown.withOpacity(0.1),
          border: Border.all(color: bgDropDown),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 77,
                  child: Text(
                    S.current.status,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: infoColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        status,
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: statusColor,
                        ),
                      ),
                      Row(
                        children: [
                          if (isShowEdit)
                            GestureDetector(
                              child: SvgPicture.asset(ImageAssets.ic_edit),
                              onTap: () {
                                funcEdit();
                              },
                            ),
                          if (isShowDelete) ...[
                            const SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              child: SvgPicture.asset(ImageAssets.ic_delete_do),
                              onTap: () {
                                funcDelete();
                              },
                            )
                          ]
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 77,
                  child: Text(
                    S.current.noi_dung,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: infoColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Text(
                    content,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: titleCalenderWork,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 77,
                  child: Text(
                    S.current.file,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: infoColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: files.map((e) {
                      return GestureDetector(
                        onTap: () {
                          saveFile(fileName: e.name ?? '', url: e.path ?? '');
                        },
                        child: Column(
                          children: [
                            Text(
                              e.name?.convertNameFile() ?? '',
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: numberOfCalenders,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
