import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/bloc/detail_row_cubit.dart';
import 'package:ccvc_mobile/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter/material.dart';

class DetailDocumentRowTablet extends StatefulWidget {
  final DocumentDetailRow row;

  const DetailDocumentRowTablet({Key? key, required this.row})
      : super(key: key);

  @override
  State<DetailDocumentRowTablet> createState() =>
      _DetailDocumentRowTabletState();
}

class _DetailDocumentRowTabletState extends State<DetailDocumentRowTablet> {
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
                  style: textNormalCustom(
                    color: titleItemEdit,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
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
                                fontSize: 16,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: titleColor,
                              ),
                            ),
                          )
                    : const SizedBox(),
              )
            ],
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
                width: 41,
                child: CustomCheckBox(
                  title: '',
                  isCheck: widget.row.value,
                ),
              ),
              AutoSizeText(
                widget.row.title,
                style: textNormalCustom(
                  color: titleItemEdit,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
      ],
    );
  }
}
