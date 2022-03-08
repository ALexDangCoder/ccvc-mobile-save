import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class LichSuCapNhatTinhHinhXuLyExpandWidgetMobile extends StatelessWidget {
  final List<LichSuVanBanModel> lichSuVanBanCapNhatModel;
  final DetailDocumentCubit cubit;

  const LichSuCapNhatTinhHinhXuLyExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.lichSuVanBanCapNhatModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.lich_su_cap_nhat_tinh_hinh_xu_ly,
                style: textNormalCustom(color: titleColumn, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: lichSuVanBanCapNhatModel.isNotEmpty
            ? lichSuVanBanCapNhatModel
                .map(
                  (e) => WidgetInExpandVanBan(
                    row: e.toListRowLichSuCapNhat(),
                    cubit: cubit,
                  ),
                )
                .toList()
            : [const NodataWidget()],
      ),
    );
  }
}
