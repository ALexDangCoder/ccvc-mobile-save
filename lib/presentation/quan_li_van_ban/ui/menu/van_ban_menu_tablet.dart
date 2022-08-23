import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VanBanMenuTablet extends StatefulWidget {
  final QLVBCCubit cubit;
  const VanBanMenuTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _VanBanMenuTabletState createState() =>
      _VanBanMenuTabletState();
}

class _VanBanMenuTabletState extends State<VanBanMenuTablet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
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
        const EdgeInsets.only(top: 28, bottom: 28),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: StreamBuilder<List<bool>>(
                stream: widget.cubit.selectTypeVanBanSubject.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [true, false];
                  return Column(
                    children: [
                      ItemMenuNhiemVuWidgetTablet(
                        isShowNumber: false,
                        number: 0,
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
                      const SizedBox(height: 20,),
                      ItemMenuNhiemVuWidgetTablet(
                        isShowNumber: false,
                        number: 0,
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
