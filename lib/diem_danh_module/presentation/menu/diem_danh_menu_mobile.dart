import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiemDanhMenuMobile extends StatefulWidget {
  final DiemDanhCubit cubit;
  final bool isThemBienSo;

  const DiemDanhMenuMobile({
    Key? key,
    required this.cubit,
    this.isThemBienSo = false,
  }) : super(key: key);

  @override
  _DiemDanhMenuMobileState createState() => _DiemDanhMenuMobileState();
}

class _DiemDanhMenuMobileState extends State<DiemDanhMenuMobile> {
  List<TypeDiemDanh> itemMenu = [
    TypeDiemDanh.CA_NHAN,
    TypeDiemDanh.KHUON_MAT,
    TypeDiemDanh.BIEN_SO_XE,
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
          headerWidget(menu: S.current.diem_danh),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<TypeDiemDanh>(
              stream: widget.cubit.typeDiemDanhStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? TypeDiemDanh.CA_NHAN;
                return Column(
                  children: itemMenu
                      .map(
                        (menuType) => menuType.getItemMenu(
                          type: menuType,
                          selectType: data,
                          onTap: () {
                            widget.cubit.typeDiemDanhSubject.add(
                              menuType,
                            );
                            Navigator.pop(context);
                            if (widget.isThemBienSo) {
                              widget.cubit.isMenuClickedSubject.add(true);
                            }
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
        SvgPicture.asset(ImageAssets.icDiemDanhTopMenu),
        const SizedBox(
          width: 12,
        ),
        Text(
          menu,
          style: textNormalCustom(
            color: AppTheme.getInstance().backGroundColor(),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
