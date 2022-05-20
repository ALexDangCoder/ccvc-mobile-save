import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/bloc/cai_dat_giao_dien_bloc.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/mobile/widgets/cai_dat_mau_widget.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/mobile/widgets/select_mua_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

List<AppBackGround> cacMuaList = [
  AppBackGround.XUAN,
  AppBackGround.HA,
  AppBackGround.THU,
  AppBackGround.DONG,
];
List<AppBackGround> cacNgayLe = [
  AppBackGround.TET_NGUYEN_DAN,
  AppBackGround.LE_TINH_NHAN,
  AppBackGround.NGAY_QUOC_TE_PHU_NU,
  AppBackGround.GIO_TO_HUNG_VUONG,
  AppBackGround.NGAY_QUOC_TE_LAO_DONG,
  AppBackGround.NGAY_QUOC_TE_THIEU_NHI,
  AppBackGround.NGAY_QUOC_KHANH,
  AppBackGround.TET_TRUNG_THU,
  AppBackGround.NGAY_PHU_NU_VIET_NAM,
  AppBackGround.NGAY_HALLOWEEN,
  AppBackGround.NGAY_NHA_GIAO_VIET_NAM,
  AppBackGround.NGAY_LE_GIANG_SINH
];

class CaiDatGiaoDienMobileScreen extends StatefulWidget {
  const CaiDatGiaoDienMobileScreen({Key? key}) : super(key: key);

  @override
  _CaiDatGiaoDienMobileScreenState createState() =>
      _CaiDatGiaoDienMobileScreenState();
}

class _CaiDatGiaoDienMobileScreenState
    extends State<CaiDatGiaoDienMobileScreen> {
  late CaiDatGiaoDienCubit cubit ;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = ProviderWidget.of<CaiDatGiaoDienCubit>(context).cubit;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorEEF3FF,
      appBar: AppBarDefaultBack(S.current.cai_dat_giao_dien),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CaiDatMauWidget(),
            const SizedBox(
              height: 6,
            ),
            SelectMuaWidget(
              title: S.current.cac_mua,
              list: cacMuaList,
            ),
            const SizedBox(
              height: 6,
            ),
            SelectMuaWidget(
              title: S.current.ngay_le,
              list: cacNgayLe,
            )
          ],
        ),
      ),
    );
  }
}
