import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/widget/widget_item_row_cong_viec.dart';
import 'package:flutter/material.dart';

class WidgetThongTinCongViecNhiemVu extends StatefulWidget {
  final ChiTietCongViecNhiemVuCubit cubit;
  final ChiTietCongViecNhiemVuModel data;

  const WidgetThongTinCongViecNhiemVu(
      {Key? key, required this.cubit, required this.data})
      : super(key: key);

  @override
  _WidgetThongTinCongViecNhiemVuState createState() =>
      _WidgetThongTinCongViecNhiemVuState();
}

class _WidgetThongTinCongViecNhiemVuState
    extends State<WidgetThongTinCongViecNhiemVu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: widget.data
              .toListMobile()
              .map(
                (row) => WidgetItemRowCongViec(
                  row: row,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
