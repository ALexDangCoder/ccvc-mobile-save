import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HoTroKyThuatMenuTablet extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const HoTroKyThuatMenuTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _HoTroKyThuatMenuTabletState createState() => _HoTroKyThuatMenuTabletState();
}

class _HoTroKyThuatMenuTabletState extends State<HoTroKyThuatMenuTablet> {
  List<TypeHoTroKyThuat> itemMenu = [
    TypeHoTroKyThuat.THONG_TIN_CHUNG,
    TypeHoTroKyThuat.DANH_SACH_SU_CO,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.menu,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icExit),
        ),
      ),
      body: StreamBuilder<TypeHoTroKyThuat>(
        stream: widget.cubit.typeHoTroKyThuatStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? TypeHoTroKyThuat.THONG_TIN_CHUNG;
          return Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              children: itemMenu
                  .map(
                    (e) => Column(
                      children: [
                        e.getItemMenuTablet(
                          type: e,
                          selectType: data,
                          onTap: () {
                            widget.cubit.typeHoTroKyThuatSubject.add(
                              e,
                            );
                            Navigator.pop(context);
                          },
                        ),
                        spaceH20,
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
