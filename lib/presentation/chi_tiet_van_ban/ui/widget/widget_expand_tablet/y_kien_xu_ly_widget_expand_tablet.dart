import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/widget_phone/y_kien_xu_y.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/dropdown_widget.dart';
import 'package:flutter/material.dart';

class YKienSuLyWidgetExpandTablet extends StatefulWidget {
  final DetailDocumentCubit cubit;
  bool expanded;

  YKienSuLyWidgetExpandTablet(
      {Key? key, required this.cubit, required this.expanded})
      : super(key: key);

  @override
  State<YKienSuLyWidgetExpandTablet> createState() =>
      _YKienSuLyWidgetExpandTabletState();
}

class _YKienSuLyWidgetExpandTabletState
    extends State<YKienSuLyWidgetExpandTablet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderButtomColor,
        ),
        color: backgroundColorApp,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: ExpansionTitleCustom(
        expand: widget.expanded,
        paddingRightIcon: const EdgeInsets.only(right: 21),
        title: Container(
          padding: const EdgeInsets.only(
            left: 16,
            top: 10.5,
            bottom: 10.5,
          ),
          child: Text(S.current.y_kien_xu_ly),
        ),
        child: YKienXuLyExpand(
          onSendComment: (text, listFileId) {},
          miss: widget.cubit.info,
        ),
        onChangeExpand: () {
          setState(() {
            widget.expanded = !widget.expanded;
          });
        },
      ),
    );
  }
}
