import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/widget/widget_item_menu_diem_danh_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiemDanhMenuMobile extends StatefulWidget {
  final DiemDanhCubit cubit;

  const DiemDanhMenuMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  _DiemDanhMenuMobileState createState() => _DiemDanhMenuMobileState();
}

class _DiemDanhMenuMobileState extends State<DiemDanhMenuMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: StreamBuilder<List<bool>>(
              stream: widget.cubit.selectTypeDiemDanhSubject.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [true, false, false];
                return Column(
                  children: [
                    ItemMenuDiemDanhWidgetMobile(
                      icon: ImageAssets.icDiemDanhCaNhan,
                      name: S.current.diem_danh_ca_nhan,
                      onTap: () {
                        widget.cubit.selectTypeDiemDanhSubject.add(
                          [true, false, false],
                        );
                        widget.cubit.emit(DiemDanhCaNhan());
                        Navigator.pop(context);
                      },
                      isSelect: data[0],
                    ),
                    ItemMenuDiemDanhWidgetMobile(
                      icon: ImageAssets.icDiemDanhKhuonMat,
                      name: S.current.quan_ly_nhan_dien_khuon_mat,
                      onTap: () {
                        widget.cubit.selectTypeDiemDanhSubject.add(
                          [false, true, false],
                        );
                        widget.cubit.emit(DiemDanhKhuonMat());
                        Navigator.pop(context);
                      },
                      isSelect: data[1],
                    ),
                    ItemMenuDiemDanhWidgetMobile(
                      icon: ImageAssets.icDiemDanhBienSoXe,
                      name: S.current.quan_ly_nhan_dien_bien_so_xe,
                      onTap: () {
                        widget.cubit.selectTypeDiemDanhSubject.add(
                          [false, false, true],
                        );
                        widget.cubit.emit(DiemDanhBienSoXe());
                        Navigator.pop(context);
                      },
                      isSelect: data[2],
                    ),
                  ],
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
            color: AppTheme.getInstance().titleColor(),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
