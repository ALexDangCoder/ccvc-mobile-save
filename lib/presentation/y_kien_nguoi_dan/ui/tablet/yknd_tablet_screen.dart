import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/ui/tablet/bao_cao_thong_ke_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/ui/tablet/thong_tin_chung_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YKienNguoiDanTablet extends StatefulWidget {
  const YKienNguoiDanTablet({Key? key}) : super(key: key);

  @override
  _YKienNguoiDanTabletState createState() => _YKienNguoiDanTabletState();
}

class _YKienNguoiDanTabletState extends State<YKienNguoiDanTablet> {
  YKienNguoiDanCubitt cubit = YKienNguoiDanCubitt();

  @override
  void initState() {
    super.initState();
    cubit.initTimeRange();
    cubit.callApi();
    cubit.emit(ThongTinChung());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YKienNguoiDanCubitt, YKienNguoiDanState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is ThongTinChung) {
          return ThongTinChungYKNDTablet(
            cubit: cubit,
          );
        } else {
          return BaoCaoThongKeTablet(
            cubit: cubit,
          );
        }
      },
    );
  }
}
