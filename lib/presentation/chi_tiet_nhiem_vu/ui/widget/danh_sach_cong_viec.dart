
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecWidget extends StatelessWidget {
  final List<DanhSachCongViecModel> dataModel;
  final ChiTietNVCubit cubit;

  const DanhSachCongViecWidget(
      {Key? key, required this.dataModel, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.danh_sach_cong_viec,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.textScale(space: 4),
          ),
          child: Column(
            children: dataModel
                .map(
                  (e) => WidgetInExpand(
                    row: e.listDSCV(),
                    cubit: cubit,
                  ),
                )
                .toList(),
          ),),
    );
  }
}
