import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class VBDiLichSuHuyDuyetExpandWidget extends StatefulWidget {
  final String id;
  final bool isTablet;
  final UnsubscribeDetailDocumentGoCubit cubit;

  const VBDiLichSuHuyDuyetExpandWidget({
    Key? key,
    required this.cubit,
    required this.id,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<VBDiLichSuHuyDuyetExpandWidget> createState() =>
      _VBDiLichSuHuyDuyetExpandWidgetState();
}

class _VBDiLichSuHuyDuyetExpandWidgetState
    extends State<VBDiLichSuHuyDuyetExpandWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getLichSuHuyDuyetVanBanDi(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getLichSuHuyDuyetVanBanDi(widget.id);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getLichSuHuyDuyetVanBanDi(widget.id);
        },
        child: StreamBuilder<List<LichSuHuyDuyetVanBanDi>>(
          stream: widget.cubit.lichSuHuyDuyetVanBanDiSubject,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            if (data.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: data
                        .map(
                          (e) => WidgetInExpandVanBan(
                            flexValue: widget.isTablet ? 8 : 5,
                            row: e.toListRowHuyDuyet(),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            } else {
              return const CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
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
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
