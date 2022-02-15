import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'bloc/detail_row_cubit.dart';

class DetailDocumentRow extends StatefulWidget {
  final DocumentDetailRow row;

  DetailDocumentRow({Key? key, required this.row}) : super(key: key);

  @override
  State<DetailDocumentRow> createState() => _DetailDocumentRowState();
}

class _DetailDocumentRowState extends State<DetailDocumentRow> {
  final DetailRowCubit cubit = DetailRowCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        if (widget.row.type == TypeDocumentDetailRow.text)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: AutoSizeText(
                  widget.row.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff667793),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
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
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          // color: widget.row.value == '' ? ,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
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
          )
        else if (widget.row.type == TypeDocumentDetailRow.status)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: AutoSizeText(
                  widget.row.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff667793),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
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
          )
      ],
    );
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
      AutoSizeText(row.title,
          style: textNormalCustom(
            fontSize: 14,
            color: const Color(0xff667793),
          )),
    ],
  );
}
