import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/tablet/diem_danh_ca_nhan_tablet_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/tablet/quan_ly_nhan_dien_bien_so_xe_tablet_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/tablet/quan_ly_nhan_dien_khuon_mat_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDiemDanhTabletScreen extends StatefulWidget {
  const MainDiemDanhTabletScreen({Key? key}) : super(key: key);

  @override
  _MainDiemDanhTabletScreenState createState() =>
      _MainDiemDanhTabletScreenState();
}

class _MainDiemDanhTabletScreenState extends State<MainDiemDanhTabletScreen> {
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
        bloc: cubit,
        builder: (context, state) {
          if (state is DiemDanhCaNhan) {
            return DiemDanhCaNhanTabletScreen(
              cubit: cubit,
            );
          } else if (state is DiemDanhKhuonMat) {
            return QuanLyNhanDienKhuonMatTabletScreen(
              cubit: cubit,
            );
          } else {
            return QuanLyNhanDienBienSoXeTabletScreen(cubit: cubit);
          }
        });
  }
}
