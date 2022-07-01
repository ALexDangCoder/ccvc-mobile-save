import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:flutter/material.dart';

class MainHoTroKyThuatMobile extends StatefulWidget {
  const MainHoTroKyThuatMobile({Key? key}) : super(key: key);

  @override
  _MainHoTroKyThuatMobileState createState() => _MainHoTroKyThuatMobileState();
}

class _MainHoTroKyThuatMobileState extends State<MainHoTroKyThuatMobile> {
  late final HoTroKyThuatCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = HoTroKyThuatCubit();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypeHoTroKyThuat>(
      stream: cubit.typeHoTroKyThuatStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? TypeHoTroKyThuat.THONG_TIN_CHUNG;
        return data.getScreen(cubit);
      },
    );
  }
}
