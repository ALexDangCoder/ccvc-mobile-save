import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/mobile/tao_lich_hop_mobile.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tablet/tao_lich_hop_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:flutter/material.dart';

class TaoLichHopScreen extends StatefulWidget {
  const TaoLichHopScreen({Key? key}) : super(key: key);

  @override
  _TaoLichHopScreenState createState() => _TaoLichHopScreenState();
}

class _TaoLichHopScreenState extends State<TaoLichHopScreen> {
  final TaoLichHopCubit _cubit = TaoLichHopCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dataUser = HiveLocal.getDataUser();
    _cubit.donViId = dataUser?.userInformation?.donViTrucThuoc?.id ?? '';
    _cubit.loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TaoLichHopCubit>(
      cubit: _cubit,
      child: screenDevice(
          mobileScreen: const TaoLichHopMobileScreen(),
          tabletScreen: const TaoLichHopMobileTabletScreen()),
    );
  }
}
