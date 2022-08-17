import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class VBDiLichSuCapNhatExpandWidget extends StatefulWidget {
  final HistoryUpdateDetailDocumentGoCubit cubit;
  final String idDocument;
  final bool isTablet;

  const VBDiLichSuCapNhatExpandWidget({
    Key? key,
    required this.cubit,
    required this.idDocument,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<VBDiLichSuCapNhatExpandWidget> createState() =>
      _VBDiLichSuCapNhatExpandWidgetState();
}

class _VBDiLichSuCapNhatExpandWidgetState
    extends State<VBDiLichSuCapNhatExpandWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getLichSuCapNhatVanBanDi(widget.idDocument);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getLichSuCapNhatVanBanDi(widget.idDocument);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getLichSuCapNhatVanBanDi(widget.idDocument);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<List<LichSuCapNhatVanBanDi>>(
            stream: widget.cubit.lichSuCapNhatVanBanDiSubject,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              if (data.isNotEmpty) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: data
                        .map(
                          (e) => WidgetInExpandVanBan(
                            flexValue: widget.isTablet ? 8 : 5,
                            row: e.toListRowCapNhat(),
                          ),
                        )
                        .toList(),
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
