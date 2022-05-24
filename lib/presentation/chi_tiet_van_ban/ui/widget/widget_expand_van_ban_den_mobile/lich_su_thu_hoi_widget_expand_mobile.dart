import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class LichSuThuHoiExpandWidgetMobile extends StatefulWidget {
  final String processId;
  final HistoryGiveBackDetailDocumentCubit cubit;

  const LichSuThuHoiExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<LichSuThuHoiExpandWidgetMobile> createState() =>
      _LichSuThuHoiExpandWidgetMobileState();
}

class _LichSuThuHoiExpandWidgetMobileState
    extends State<LichSuThuHoiExpandWidgetMobile>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getLichSuVanBanLichSuThuHoi(widget.processId, THU_HOI);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getLichSuVanBanLichSuThuHoi(widget.processId, THU_HOI);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit
              .getLichSuVanBanLichSuThuHoi(widget.processId, THU_HOI);
        },
        child: StreamBuilder<List<LichSuVanBanModel>>(
          stream: widget.cubit.lichSuThuHoiStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            if (data.isEmpty) {
              return const CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: NodataWidget(),
                    ),
                  ),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: data
                      .map(
                        (e) => WidgetInExpandVanBan(
                          row: e.toListRowLichSuThuHoi(),
                        ),
                      )
                      .toList(),
                ),
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
