import 'package:ccvc_mobile/home_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/bloc/cai_dat_giao_dien_bloc.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/mobile/cai_dat_giao_dien_mobile.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/tablet/cai_dat_giao_dien_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

class CaiDatGiaoDienScreen extends StatefulWidget {
  const CaiDatGiaoDienScreen({Key? key}) : super(key: key);

  @override
  _CaiDatGiaoDienScreenState createState() => _CaiDatGiaoDienScreenState();
}

class _CaiDatGiaoDienScreenState extends State<CaiDatGiaoDienScreen> {
  final CaiDatGiaoDienCubit cubit = CaiDatGiaoDienCubit();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CaiDatGiaoDienCubit>(
      cubit: cubit,
      child: screenDevice(
          mobileScreen: const CaiDatGiaoDienMobileScreen(),
          tabletScreen: const CaiDatGiaoDienTablet()),
    );
  }
}
