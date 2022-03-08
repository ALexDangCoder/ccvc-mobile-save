import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class ThongTinGuiNhanExpandWidgetMobile extends StatelessWidget {
  final List<ThongTinGuiNhanModel> thongTinGuiNhanModel;
  final DetailDocumentCubit cubit;

  const ThongTinGuiNhanExpandWidgetMobile({
    Key? key,
    required this.thongTinGuiNhanModel,
    required this.cubit,
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
                S.current.thong_tin_gui_nhan,
                style: textNormalCustom(color: titleColumn, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: thongTinGuiNhanModel.isNotEmpty
            ? thongTinGuiNhanModel
                .map(
                  (e) => WidgetInExpandVanBan(
                    row: e.toListRow(),
                    cubit: cubit,
                  ),
                )
                .toList()
            : [const NodataWidget()],
      ),
    );
  }
}
