import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class LichSuVanBanLienThongExpandWidgetMobile extends StatelessWidget {
  final List<LichSuVanBanModel> listLichSuVanBanLienThongModel;
  final DetailDocumentCubit cubit;

  const LichSuVanBanLienThongExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.listLichSuVanBanLienThongModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.lich_su_van_ban_lien_thong,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: listLichSuVanBanLienThongModel.isNotEmpty
              ? listLichSuVanBanLienThongModel
                  .map(
                    (e) => WidgetInExpandVanBan(
                      cubit: cubit,
                      row: e.toListRowLichSuVanBanLienThong(),
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
