import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class LichSuTraLaiWidgetExpandTablet extends StatefulWidget {
  final HistoryRecallDetailDocumentCubit cubit;
  final String processId;

  const LichSuTraLaiWidgetExpandTablet({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<LichSuTraLaiWidgetExpandTablet> createState() =>
      _LichSuTraLaiWidgetExpandTabletState();
}

class _LichSuTraLaiWidgetExpandTabletState
    extends State<LichSuTraLaiWidgetExpandTablet>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getLichSuVanBanLichSuTraLai(widget.processId, TRA_LAI);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getLichSuVanBanLichSuTraLai(widget.processId, TRA_LAI);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getLichSuVanBanLichSuTraLai(
            widget.processId,
            TRA_LAI,
          );
        },
        child: StreamBuilder<List<LichSuVanBanModel>>(
          stream: widget.cubit.lichSuTraLaiStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: data.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: data
                            .map(
                              (e) => WidgetInExpandVanBan(
                                flexValue: 8,
                                row: e.toListRowLichSuTraLai(),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : const CustomScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: NodataWidget(),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
