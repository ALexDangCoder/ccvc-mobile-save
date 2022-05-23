import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/mobile/chi_tiet_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecWidget extends StatelessWidget {
  final List<DanhSachCongViecChiTietNhiemVuModel> dataModel;
  final ChiTietNVCubit cubit;

  const DanhSachCongViecWidget(
      {Key? key, required this.dataModel, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataModel.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.getDanhSachCongViecChiTietNhiemVu(
            cubit.idNhiemVu,
            false,
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: dataModel
                .map(
                  (e) => WidgetInExpand(
                    row: e.listDSCV(),
                    cubit: cubit,
                    hasTap: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChitietCongViecNhiemVuMobile(
                            id: e.id ?? '',
                          ),
                        ),
                      );
                    },
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
