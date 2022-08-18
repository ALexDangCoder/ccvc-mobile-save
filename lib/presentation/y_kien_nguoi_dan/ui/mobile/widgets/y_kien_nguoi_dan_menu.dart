import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YKienNguoiDanMenu extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const YKienNguoiDanMenu({Key? key, required this.cubit}) : super(key: key);

  @override
  _YKienNguoiDanMenuState createState() => _YKienNguoiDanMenuState();
}

class _YKienNguoiDanMenuState extends State<YKienNguoiDanMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDrawerMenu,
      body: Column(
        children: [
          const SizedBox(
            height: 58,
          ),
          headerWidget(menu: S.current.phan_anh_kien_nghi),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<List<bool>>(
              stream: widget.cubit.selectTypeYKNDSubject.stream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [true, false];
                return Column(
                  children: [
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icPersonItemMenu,
                      name: S.current.thong_tin_chung,
                      onTap: () {
                        widget.cubit.selectTypeYKNDSubject.add(
                          [true, false],
                        );
                        widget.cubit.emit(ThongTinChung());
                        Navigator.pop(context);
                      },
                      isSelect: data[0],
                    ),
                    ItemMenuNhiemVuWidgetMobile(
                      icon: ImageAssets.icBaoCaoItemNenu,
                      name: S.current.bao_cao_thong_ke,
                      onTap: () {
                        widget.cubit.selectTypeYKNDSubject.add(
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
        SvgPicture.asset(ImageAssets.icMessItemMenu),
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

class ItemMenu extends StatelessWidget {
  final Widget widgetItem;
  final String textItem;
  final bool isTitile;

  const ItemMenu({
    Key? key,
    required this.widgetItem,
    required this.textItem,
    required this.isTitile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widgetItem,
        const SizedBox(
          width: 12,
        ),
        Text(
          textItem,
          style: textNormalCustom(
            fontWeight: isTitile ? FontWeight.w500 : FontWeight.w400,
            color: Colors.white,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
