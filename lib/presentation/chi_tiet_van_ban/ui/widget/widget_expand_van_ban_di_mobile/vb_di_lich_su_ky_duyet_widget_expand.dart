import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class VBDiLichSuKyDuyetExpandWidget extends StatelessWidget {
  final List<LichSuKyDuyetVanBanDi> lichSuKyDuyetModel;
  final DetailDocumentCubit cubit;

  VBDiLichSuKyDuyetExpandWidget({
    Key? key,
    required this.cubit,
    required this.lichSuKyDuyetModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.lich_su_ky_duyet,
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: lichSuKyDuyetModel.isNotEmpty
              ? lichSuKyDuyetModel
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
      ),
    );
  }
}
