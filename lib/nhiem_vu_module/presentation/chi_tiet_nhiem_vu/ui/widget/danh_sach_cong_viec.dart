import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
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
      return Column(
        children: [
          Container(
            height: 1,
            color: radioUnfocusColor,
          ),
          Column(
            children: dataModel
                .map(
                  (e) => WidgetInExpand(
                row: e.listDSCV(),
                cubit: cubit,
              ),
            )
                .toList(),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            height: 1,
            color: radioUnfocusColor,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: NodataWidget(),
          ),
        ],
      );
    }
  }
}
