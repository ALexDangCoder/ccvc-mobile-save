import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HoTroKyThuatMenuMobile extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const HoTroKyThuatMenuMobile({Key? key, required this.cubit})
      : super(key: key);

  @override
  _HoTroKyThuatMenuMobileState createState() => _HoTroKyThuatMenuMobileState();
}

class _HoTroKyThuatMenuMobileState extends State<HoTroKyThuatMenuMobile> {
  List<TypeHoTroKyThuat> itemMenu = [
    TypeHoTroKyThuat.THONG_TIN_CHUNG,
    TypeHoTroKyThuat.DANH_SACH_SU_CO,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDrawerMenu,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 58,
          ),
          headerWidget(menu: S.current.ho_tro_ky_thuat),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<TypeHoTroKyThuat>(
              stream: widget.cubit.typeHoTroKyThuatStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? TypeHoTroKyThuat.THONG_TIN_CHUNG;
                return Column(
                  children: itemMenu
                      .map(
                        (e) => e.getItemMenu(
                          type: e,
                          selectType: data,
                          onTap: () {
                            widget.cubit.typeHoTroKyThuatSubject.add(
                              e,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget headerWidget({required String menu}) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(ImageAssets.ic_ho_tro_ky_thuat),
        const SizedBox(
          width: 12,
        ),
        Text(
          menu,
          style: textNormalCustom(
            color: backgroundColorApp,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
