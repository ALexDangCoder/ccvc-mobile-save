
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:flutter/material.dart';

class LichSuTraLaiWidget extends StatelessWidget {
  final List<LichSuTraLaiNhiemVuModel> dataModel;
  final ChiTietNVCubit cubit;

  const LichSuTraLaiWidget(
      {Key? key, required this.dataModel, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataModel.isNotEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: dataModel
              .map(
                (e) => WidgetInExpand(
                  row: e.toListRowLichSuTraLai(),
                  cubit: cubit,
                ),
              )
              .toList(),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: NodataWidget(),
      );
    }
  }
}
