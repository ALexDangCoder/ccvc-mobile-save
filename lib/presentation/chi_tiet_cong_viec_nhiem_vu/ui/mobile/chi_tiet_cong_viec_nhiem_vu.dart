import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_cong_viec_nhiem_vu/widget/widget_thong_tin_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChitietCongViecNhiemVuMobile extends StatefulWidget {
  const ChitietCongViecNhiemVuMobile({Key? key}) : super(key: key);

  @override
  _ChitietCongViecNhiemVuMobileState createState() =>
      _ChitietCongViecNhiemVuMobileState();
}

class _ChitietCongViecNhiemVuMobileState
    extends State<ChitietCongViecNhiemVuMobile> {
  ChiTietCongViecNhiemVuCubit cubit = ChiTietCongViecNhiemVuCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.chi_tiet_cong_viec),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              WidgetThongTinCongViecNhiemVu(cubit),
            ],
          ),
        ),
      ),
    );
  }
}
