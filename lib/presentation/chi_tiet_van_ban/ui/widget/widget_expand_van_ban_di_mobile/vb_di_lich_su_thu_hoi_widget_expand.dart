import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class VBDiLichSuThuHoiExpandWidget extends StatefulWidget {
  final String id;
  final HistoryRecallDetailDocumentGoCubit cubit;

  const VBDiLichSuThuHoiExpandWidget({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  State<VBDiLichSuThuHoiExpandWidget> createState() =>
      _VBDiLichSuThuHoiExpandWidgetState();
}

class _VBDiLichSuThuHoiExpandWidgetState
    extends State<VBDiLichSuThuHoiExpandWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getLichSuThuHoiVanBanDi(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getLichSuThuHoiVanBanDi(widget.id);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getLichSuThuHoiVanBanDi(widget.id);
        },
        child: StreamBuilder<List<LichSuThuHoiVanBanDi>>(
          stream: widget.cubit.lichSuThuHoiVanBanDiSubject,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                physics: const  AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: data.isNotEmpty
                      ? data
                          .map(
                            (e) => WidgetInExpandVanBan(
                              row: e.toListRowThuHoi(),
                            ),
                          )
                          .toList()
                      : [
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: NodataWidget(),
                          )
                        ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}
