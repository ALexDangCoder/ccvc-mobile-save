import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/dropdown_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/history_widget/history_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class LichSuTraLaiWidgetExpandTablet extends StatefulWidget {
  final DetailDocumentCubit cubit;
  bool expanded;

  LichSuTraLaiWidgetExpandTablet(
      {Key? key, required this.cubit, required this.expanded})
      : super(key: key);

  @override
  State<LichSuTraLaiWidgetExpandTablet> createState() =>
      _LichSuTraLaiWidgetExpandTabletState();
}

class _LichSuTraLaiWidgetExpandTabletState
    extends State<LichSuTraLaiWidgetExpandTablet> {
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
        child: Text(S.current.lich_su_tra_lai),
      ),
      child: StreamBuilder<HistoryProcessPage>(
        stream: widget.cubit.screenJobProfilesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && widget.cubit.listHistory.isNotEmpty) {
            return HistoryWidget(widget.cubit);
          } else {
            return const NodataWidget();
          }
        },
      ),
      onChangeExpand: () {
        setState(() {
          widget.expanded = !widget.expanded;
        });
      },
    );
  }
}
