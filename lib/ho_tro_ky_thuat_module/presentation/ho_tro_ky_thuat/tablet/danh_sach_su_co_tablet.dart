import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:flutter/material.dart';

class DanhSachSuCoTablet extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const DanhSachSuCoTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<DanhSachSuCoTablet> createState() => _DanhSachSuCoTabletState();
}

class _DanhSachSuCoTabletState extends State<DanhSachSuCoTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
