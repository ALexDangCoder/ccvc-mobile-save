import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:flutter/material.dart';

class ThongTinChungTablet extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const ThongTinChungTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThongTinChungTablet> createState() => _ThongTinChungTabletState();
}

class _ThongTinChungTabletState extends State<ThongTinChungTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
