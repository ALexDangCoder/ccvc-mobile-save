import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/mobile/diem_danh_ca_nhan_mobile_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/mobile/quan_ly_nhan_dien_bien_so_xe_mobile_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/mobile/quan_ly_nhan_dien_khuon_mat_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDiemDanhScreen extends StatefulWidget {
  const MainDiemDanhScreen({Key? key}) : super(key: key);

  @override
  _MainDiemDanhScreenState createState() => _MainDiemDanhScreenState();
}

class _MainDiemDanhScreenState extends State<MainDiemDanhScreen> {
  late final DiemDanhCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = DiemDanhCubit();
    cubit.emit(DiemDanhCaNhan());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiemDanhCubit, DiemDanhState>(
      bloc:cubit ,
        builder: (context, state) {
      if (state is DiemDanhCaNhan) {
        return DiemDanhCaNhanMobileScreen(
          cubit: cubit,
        );
      } else if (state is DiemDanhKhuonMat) {
        return QuanLyNhanDienKhuonMatMobileScreen(
          cubit: cubit,
        );
      } else {
        return QuanLyNhanDienBienSoXeMobileScreen(cubit: cubit);
      }
    });
  }
}
