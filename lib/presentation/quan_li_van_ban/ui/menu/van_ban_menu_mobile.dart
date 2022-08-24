import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VanBanMenuMobile extends StatefulWidget {
  final QLVBCCubit cubit;

  const VanBanMenuMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  State<VanBanMenuMobile> createState() => _VanBanMenuMobileState();
}

class _VanBanMenuMobileState extends State<VanBanMenuMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundDrawerMenu,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 58,
          ),
          headerWidget(menu: S.current.quan_ly_van_ban),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<List<bool>>(
              stream: widget.cubit.selectTypeVanBanSubject.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [true, false];
                return Column(
                  children: [
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icCircleWarning,
                      name: S.current.thong_tin_van_ban,
                      onTap: () {
                        widget.cubit.selectTypeVanBanSubject.add(
                          [true, false],
                        );
                        widget.cubit.emit(ThongTinVanBan());
                        Navigator.pop(context);
                      },
                      isSelect: data[0],
                    ),
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icThongKe,
                      name: S.current.bao_cao_thong_ke,
                      onTap: () {
                        widget.cubit.selectTypeVanBanSubject.add(
                          [false, true],
                        );
                        widget.cubit.emit(BaoCaoThongKe());
                        Navigator.pop(context);
                      },
                      isSelect: data[1],
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
        SvgPicture.asset(ImageAssets.icQuanLyVanBan),
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
