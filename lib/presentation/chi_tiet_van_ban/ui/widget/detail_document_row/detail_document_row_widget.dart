import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/widgets/checkbox/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/detail_row_cubit.dart';

class DetailDocumentRow extends StatefulWidget {
  final DocumentDetailRow row;
  final bool isTablet;

  const DetailDocumentRow({
    Key? key,
    required this.row,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<DetailDocumentRow> createState() => _DetailDocumentRowState();
}

class _DetailDocumentRowState extends State<DetailDocumentRow> {
  final DetailRowCubit cubit = DetailRowCubit();

  @override
  Widget build(BuildContext context) {
    switch (widget.row.type) {
      case TypeDocumentDetailRow.fileActacks:
        {
          List<FileDinhKems> data = [];
          try {
            data = widget.row.value as List<FileDinhKems>;
          } catch (_) {}
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: AutoSizeText(
                    widget.row.title,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: titleColumn,
                    ),
                  ),
                ),
                Expanded(
                  flex: widget.isTablet ? 26 : 6,
                  child: Wrap(
                    children: data
                        .map(
                          (e) => GestureDetector(
                            onTap: () async {
                              final status = await Permission.storage.status;
                              if (!status.isGranted) {
                                await Permission.storage.request();
                                await Permission.manageExternalStorage
                                    .request();
                              }

                              await saveFile(
                                e.ten ?? '',
                                e.duongDan ?? '',
                              )
                                  .then(
                                    (value) => MessageConfig.show(
                                      title: S.current.tai_file_thanh_cong,
                                    ),
                                  )
                                  .onError(
                                    (error, stackTrace) => MessageConfig.show(
                                      title: S.current.tai_file_that_bai,
                                      messState: MessState.error,
                                    ),
                                  );
                            },
                            child: Text(
                              e.ten ?? '',
                              style: textNormalCustom(
                                color: choXuLyColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        }
      case TypeDocumentDetailRow.status:
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: AutoSizeText(
                    widget.row.title,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: titleColumn,
                    ),
                  ),
                ),
                Expanded(
                  flex: widget.isTablet ? 26 : 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: daXuLyColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 3,
                          ),
                          child: Text(
                            '${widget.row.value}',
                            style: textNormalCustom(
                              fontSize: 14,
                              color: titleColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Expanded(flex: 3, child: SizedBox())
              ],
            ),
          );
        }
      case TypeDocumentDetailRow.text:
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: AutoSizeText(
                    widget.row.title,
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: titleColumn,
                    ),
                  ),
                ),
                Expanded(
                  flex: widget.isTablet ? 26 : 6,
                  child: widget.row.type == TypeDocumentDetailRow.text
                      ? cubit.isCheckLine
                          ? GestureDetector(
                              onTap: () {
                                cubit.isCheckLine = !cubit.isCheckLine;
                                setState(() {});
                              },
                              child: Text(
                                '${widget.row.value}',
                                style: textNormalCustom(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: titleColor,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                cubit.isCheckLine = !cubit.isCheckLine;
                                setState(
                                  () {},
                                );
                              },
                              child: Text(
                                '${widget.row.value}',
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: titleColor,
                                ),
                              ),
                            )
                      : Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: daXuLyColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 3,
                            ),
                            child: Text(
                              '${widget.row.value}',
                              style: textNormalCustom(
                                fontSize: 14,
                                color: titleColor,
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          );
        }
      default:
        return const SizedBox.shrink();
    }
  }
}

Widget checkBoxCusTom(DocumentDetailRow row) {
  return Row(
    // mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 20,
        width: 41,
        child: CustomCheckBox(
          title: '',
          isCheck: row.value,
        ),
      ),
      AutoSizeText(
        row.title,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: titleColumn,
        ),
      ),
    ],
  );
}
