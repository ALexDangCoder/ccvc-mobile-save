import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/tablet/widgets/cai_dat_mau_tablet.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/tablet/widgets/select_mua_widget_tablet.dart';
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

class CaiDatGiaoDienTablet extends StatefulWidget {
  const CaiDatGiaoDienTablet({Key? key}) : super(key: key);

  @override
  _CaiDatGiaoDienTabletState createState() => _CaiDatGiaoDienTabletState();
}

class _CaiDatGiaoDienTabletState extends State<CaiDatGiaoDienTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorEEF3FF,
      appBar: AppBarDefaultBack(S.current.cai_dat_giao_dien),
      body: SingleChildScrollView(
        child: Column(
          children: [
          const  CaiDatMauTabletWidget(),
            const SizedBox(
              height: 6,
            ),
            SelectMuaTabletWidget(
              title: S.current.cac_mua,
              list: cacMuaList,
            ),
            const SizedBox(
              height: 6,
            ),
            SelectMuaTabletWidget(
              title: S.current.ngay_le,
              list: cacNgayLe,
            )
          ],
        ),
      ),
    );
  }
}
