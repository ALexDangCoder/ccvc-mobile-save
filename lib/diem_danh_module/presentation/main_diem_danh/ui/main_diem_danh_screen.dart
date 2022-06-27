import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypeDiemDanh>(
      stream: cubit.typeDiemDanhStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? TypeDiemDanh.CA_NHAN;
        return data.getScreen(cubit);
      },
    );
  }
}
