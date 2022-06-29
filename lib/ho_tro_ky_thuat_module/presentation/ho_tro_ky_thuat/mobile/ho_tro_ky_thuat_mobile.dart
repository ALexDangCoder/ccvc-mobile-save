import 'package:ccvc_mobile/bao_cao_module/widget/appbar/mobile/base_app_bar_mobile.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/menu/ho_tro_ky_thuat_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HoTroKyThuatMobile extends StatefulWidget {
  const HoTroKyThuatMobile({Key? key}) : super(key: key);

  @override
  State<HoTroKyThuatMobile> createState() => _HoTroKyThuatMobileState();
}

class _HoTroKyThuatMobileState extends State<HoTroKyThuatMobile> {
  late final HoTroKyThuatCubit cubit;

  @override
  void initState() {
    cubit = HoTroKyThuatCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarMobile(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: HoTroKyThuatMenuMobile(
                  cubit: cubit,
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          )
        ],
      ),
    );
  }
}
