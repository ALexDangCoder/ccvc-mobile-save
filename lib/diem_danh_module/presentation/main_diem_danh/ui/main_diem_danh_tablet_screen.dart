import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypeDiemDanh>(
      stream: cubit.typeDiemDanhStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? TypeDiemDanh.CA_NHAN;
        return data.getScreenTablet(cubit);
      },
    );
  }
}
