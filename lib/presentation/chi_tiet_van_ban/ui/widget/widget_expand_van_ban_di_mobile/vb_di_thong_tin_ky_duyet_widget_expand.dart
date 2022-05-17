import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class VBDiThongTinKyDuyetExpandWidgetMobile extends StatelessWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String idDocument;

  const VBDiThongTinKyDuyetExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.idDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        cubit.getChiTietVanBanDi(idDocument);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await cubit.getChiTietVanBanDi(idDocument);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<List<NguoiKyDuyetModel>>(
            stream: cubit.nguoiKyDuyetVanBanDiSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: data.isNotEmpty
                      ? data
                          .map(
                            (e) => WidgetInExpandVanBan(
                              row: e.toListRowKyDuyet(),
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
              );
            }
          ),
        ),
      ),
    );
  }
}
