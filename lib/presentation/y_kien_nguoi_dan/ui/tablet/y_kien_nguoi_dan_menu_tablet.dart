import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/container_menu_bao_chi_tablet_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuYKienNguoiDanTablet extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;
  final Function() onChange;

  const MenuYKienNguoiDanTablet({
    Key? key,
    required this.cubit,
    required this.onChange,
  }) : super(key: key);

  @override
  _MenuYKienNguoiDanTabletState createState() =>
      _MenuYKienNguoiDanTabletState();
}

class _MenuYKienNguoiDanTabletState extends State<MenuYKienNguoiDanTablet> {
  TheoDoiBaiVietCubit theoDoiBaiVietCubit = TheoDoiBaiVietCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorF9FAFF,
      appBar: BaseAppBar(
        title: S.current.menu,
        leadingIcon: IconButton(
          icon: SvgPicture.asset(
            ImageAssets.icClose,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 28),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  ContainerMenuYKNDTabletWidget(
                    icon: ImageAssets.ic_preson_menu_yknd,
                    name: S.current.thong_tin_chung,
                    onTap: () {
                      widget.cubit.selectTypeYKNDSubject.add(
                        [true, false],
                      );
                      widget.cubit.emit(ThongTinChung());
                      Navigator.pop(context);
                    },
                  ),
                  ContainerMenuYKNDTabletWidget(
                    icon: ImageAssets.ic_baocao_menu_yknd,
                    name: S.current.bao_cao_thong_ke,
                    onTap: () {
                      widget.cubit.selectTypeYKNDSubject.add(
                        [false, true],
                      );
                      widget.cubit.emit(BaoCaoThongKe());
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget({required String menu}) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(ImageAssets.icHeaderMenuBCMXH),
        const SizedBox(
          width: 12,
        ),
        Text(
          menu,
          style: textNormalCustom(
            color: color3D5586,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
