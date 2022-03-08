import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/dropdown_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class ThongTinGuiNhanWidgetExpandTablet extends StatefulWidget {
  final List<ThongTinGuiNhanModel> thongTinGuiNhanModel;
  final DetailDocumentCubit cubit;
  bool expanded;

  ThongTinGuiNhanWidgetExpandTablet({
    Key? key,
    required this.cubit,
    required this.expanded,
    required this.thongTinGuiNhanModel,
  }) : super(key: key);

  @override
  State<ThongTinGuiNhanWidgetExpandTablet> createState() =>
      _ThongTinGuiNhanWidgetExpandTabletState();
}

class _ThongTinGuiNhanWidgetExpandTabletState
    extends State<ThongTinGuiNhanWidgetExpandTablet> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTitleCustom(
      expand: widget.expanded,
      paddingRightIcon: const EdgeInsets.only(right: 21),
      title: Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 10.5,
          bottom: 10.5,
        ),
        child: Text(S.current.thong_tin_gui_nhan),
      ),
      onChangeExpand: () {
        setState(() {
          widget.expanded = !widget.expanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child:Column(
          children: widget.thongTinGuiNhanModel.isNotEmpty
              ? widget.thongTinGuiNhanModel
              .map(
                (e) => WidgetInExpandVanBan(
              row: e.toListRow(),
              cubit: widget.cubit,
            ),
          )
              .toList()
              : [ const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: NodataWidget(),
              )],
        )
      ),
    );
  }
}
