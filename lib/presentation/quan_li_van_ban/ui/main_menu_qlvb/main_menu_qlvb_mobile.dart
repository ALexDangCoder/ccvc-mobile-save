import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/qlvb_mobile_screen.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/report_statistical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuQlVBMobile extends StatefulWidget {
  const MainMenuQlVBMobile({Key? key}) : super(key: key);

  @override
  _MainMenuQlVBMobileState createState() => _MainMenuQlVBMobileState();
}

class _MainMenuQlVBMobileState extends State<MainMenuQlVBMobile> {
  late final QLVBCCubit cubit;

  @override
  void initState() {
    cubit = QLVBCCubit();
    cubit.emit(ThongTinVanBan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QLVBCCubit, QLVBState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is ThongTinVanBan) {
          return QLVBMobileScreen(
            qlvbCubit: cubit,
          );
        } else {
          return ReportStatical(
            cubit: cubit,
          );
        }
      },
    );
  }
}
