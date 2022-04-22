import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuYKIenNguoiDanTablet extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const MenuYKIenNguoiDanTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _MenuYKIenNguoiDanTabletState createState() =>
      _MenuYKIenNguoiDanTabletState();
}

class _MenuYKIenNguoiDanTabletState extends State<MenuYKIenNguoiDanTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.menu,
        leadingIcon:IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icExit),
        ),
      ),
      body: StreamBuilder<List<bool>>(
        stream: widget.cubit.selectTypeYKNDSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [true, false];
          return Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              ItemMenuNhiemVuWidgetTablet(
                icon: ImageAssets.icPerson,
                number: 20,
                name: S.current.thong_tin_chung,
                onTap: () {
                  widget.cubit.selectTypeYKNDSubject.add([true, false]);
                  widget.cubit.emit(ThongTinChung());
                  Navigator.pop(context);
                },
                isSelect: data[0],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
              ),
              ItemMenuNhiemVuWidgetTablet(
                icon: ImageAssets.ic_baocao,
                number: 20,
                name: S.current.bao_cao_thong_ke,
                onTap: () {
                  widget.cubit.selectTypeYKNDSubject.add([false, true]);
                  widget.cubit.emit(BaoCaoThongKe());
                  Navigator.pop(context);
                },
                isSelect: data[1],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
