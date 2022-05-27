import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/ui/mobile/bao_cao_thong_ke_screen.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/ui/mobile/thong_tin_chung_screen.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YKienNguoiDanScreen extends StatefulWidget {
  const YKienNguoiDanScreen({Key? key}) : super(key: key);

  @override
  _YKienNguoiDanScreenState createState() => _YKienNguoiDanScreenState();
}

class _YKienNguoiDanScreenState extends State<YKienNguoiDanScreen> {
  YKienNguoiDanCubitt cubit = YKienNguoiDanCubitt();
  ThanhPhanThamGiaCubit thamGiaCubit = ThanhPhanThamGiaCubit();

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
          return ThongTinChungYKNDScreen(
            cubit: cubit,
          );
        } else {
          return BaoCaoThongKeScreen(
            cubit: cubit,
          );
        }
      },
    );
  }
}
