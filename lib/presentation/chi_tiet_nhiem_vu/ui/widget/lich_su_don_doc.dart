import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import 'expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

class LichSuDonDocWidget extends StatelessWidget {
  final List<LichSuDonDocModel> dataModel;
  final ChiTietNVCubit cubit;

  const LichSuDonDocWidget(
      {Key? key, required this.dataModel, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.lich_su_don_doc,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.textScale(space: 4),
        ),
        child: Column(
          children: dataModel
              .map(
                (e) => WidgetInExpand(
                  row: e.listLSDD(),
                  cubit: cubit,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
