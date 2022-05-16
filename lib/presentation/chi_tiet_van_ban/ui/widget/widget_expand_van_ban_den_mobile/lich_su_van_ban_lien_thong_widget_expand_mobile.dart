import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class LichSuVanBanLienThongExpandWidgetMobile extends StatefulWidget {
  final DetailDocumentCubit cubit;
  final String processId;

  const LichSuVanBanLienThongExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<LichSuVanBanLienThongExpandWidgetMobile> createState() =>
      _LichSuVanBanLienThongExpandWidgetMobileState();
}

class _LichSuVanBanLienThongExpandWidgetMobileState
    extends State<LichSuVanBanLienThongExpandWidgetMobile>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getLichSuVanBanLichSuLienThong(widget.processId, LIEN_THONG);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getLichSuVanBanLichSuLienThong(
          widget.processId,
          LIEN_THONG,
        );
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getLichSuVanBanLichSuLienThong(
            widget.processId,
            LIEN_THONG,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: StreamBuilder<List<LichSuVanBanModel>>(
                  stream: widget.cubit.lichSuVanBanLienThongStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return data.isNotEmpty
                        ? Column(
                            children: data
                                .map(
                                  (e) => WidgetInExpandVanBan(
                                    cubit: widget.cubit,
                                    row: e.toListRowLichSuVanBanLienThong(),
                                  ),
                                )
                                .toList(),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: NodataWidget(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
