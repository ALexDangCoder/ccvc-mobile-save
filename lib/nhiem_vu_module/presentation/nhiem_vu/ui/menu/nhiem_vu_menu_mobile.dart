import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NhiemVuMenuMobile extends StatefulWidget {
  final NhiemVuCubit cubit;

  const NhiemVuMenuMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  State<NhiemVuMenuMobile> createState() => _NhiemVuMenuMobileState();
}

class _NhiemVuMenuMobileState extends State<NhiemVuMenuMobile> {
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
          headerWidget(menu: S.current.quan_ly_nhiem_vu),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<List<bool>>(
              stream: widget.cubit.selectTypeNhiemVuSubject.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [true, false, false];
                return Column(
                  children: [
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icPerson,
                      name: S.current.nhiem_vu_ca_nhan,
                      onTap: () {
                        widget.cubit.selectTypeNhiemVuSubject.add(
                          [true, false, false],
                        );
                        widget.cubit.emit(NhiemVuCaNhan());
                        Navigator.pop(context);
                      },
                      isSelect: data[0],
                    ),
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icDonViNhiemVu,
                      name: S.current.nhiem_vu_don_vi,
                      onTap: () {
                        widget.cubit.selectTypeNhiemVuSubject.add(
                          [false, true, false],
                        );
                        widget.cubit.emit(NhiemVuDonVi());
                        Navigator.pop(context);
                      },
                      isSelect: data[1],
                    ),
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icThongKe,
                      name: S.current.bao_cao_thong_ke,
                      onTap: () {
                        widget.cubit.selectTypeNhiemVuSubject.add(
                          [false, false, true],
                        );
                        widget.cubit.emit(BaoCaoThongKe());
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
        SvgPicture.asset(ImageAssets.icQuanLyNhiemVu),
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
