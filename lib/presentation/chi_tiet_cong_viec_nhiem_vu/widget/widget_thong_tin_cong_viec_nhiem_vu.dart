import 'package:ccvc_mobile/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_cong_viec_nhiem_vu/widget/widget_item_row_cong_viec.dart';
import 'package:flutter/material.dart';

class WidgetThongTinCongViecNhiemVu extends StatefulWidget {
  ChiTietCongViecNhiemVuCubit cubit;

  WidgetThongTinCongViecNhiemVu(this.cubit, {Key? key}) : super(key: key);

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
          children: widget.cubit.chiTietCongViecNhiemVuModel
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
