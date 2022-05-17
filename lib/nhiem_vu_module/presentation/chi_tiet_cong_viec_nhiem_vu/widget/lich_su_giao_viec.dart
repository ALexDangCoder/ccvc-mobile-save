import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/mobile/chi_tiet_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:flutter/material.dart';

class LichSuGiaoViecWidget extends StatefulWidget {
  final List<DanhSachCongViecChiTietNhiemVuModel> dataModel;
  final ChiTietCongViecNhiemVuCubit cubit;
  final String id;

  const LichSuGiaoViecWidget({
    Key? key,
    required this.dataModel,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  State<LichSuGiaoViecWidget> createState() => _LichSuGiaoViecWidgetState();
}

class _LichSuGiaoViecWidgetState extends State<LichSuGiaoViecWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataModel.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getLichSuGiaoViec(widget.id);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: widget.dataModel
                .map(
                  (e) => WidgetInExpand(
                    row: e.listLSGV(),
                  ),
                )
                .toList(),
          ),
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
