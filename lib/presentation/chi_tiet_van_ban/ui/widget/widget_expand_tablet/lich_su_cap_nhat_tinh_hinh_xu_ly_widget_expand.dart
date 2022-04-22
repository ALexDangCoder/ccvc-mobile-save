import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class LichSuCapNhatTinhHinhWidgetExpandTablet extends StatefulWidget {
  final DetailDocumentCubit cubit;
  final List<LichSuVanBanModel> lichSuVanBanCapNhatModel;

  LichSuCapNhatTinhHinhWidgetExpandTablet({
    Key? key,
    required this.cubit,
    required this.lichSuVanBanCapNhatModel,
  }) : super(key: key);

  @override
  State<LichSuCapNhatTinhHinhWidgetExpandTablet> createState() =>
      _LichSuCapNhatTinhHinhWidgetExpandTabletState();
}

class _LichSuCapNhatTinhHinhWidgetExpandTabletState
    extends State<LichSuCapNhatTinhHinhWidgetExpandTablet> {
  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.lich_su_cap_nhat,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.textScale(space: 4),
        ),
        child: Column(
          children: widget.lichSuVanBanCapNhatModel.isNotEmpty
              ? widget.lichSuVanBanCapNhatModel
                  .map(
                    (e) => WidgetInExpandVanBan(
                      row: e.toListRowLichSuCapNhat(),
                      cubit: widget.cubit,
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
