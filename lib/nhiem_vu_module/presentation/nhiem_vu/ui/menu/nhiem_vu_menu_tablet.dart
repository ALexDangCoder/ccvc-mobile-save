import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/widget_item_menu_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';


import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NhiemVuMenuTablet extends StatefulWidget {
  final NhiemVuCubit cubit;

  const NhiemVuMenuTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _NhiemVuMenuTabletState createState() => _NhiemVuMenuTabletState();
}

class _NhiemVuMenuTabletState extends State<NhiemVuMenuTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.menu,
        leadingIcon:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icExit),
        ),
      ),
      body: StreamBuilder<List<bool>>(
        stream: widget.cubit.selectTypeNhiemVuSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [true, false];
          return Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              ItemMenuNhiemVuWidgetTablet(
                isShowNumber: false,
                icon: ImageAssets.icPerson,
                number: 20,
                name: S.current.nhiem_vu_ca_nhan,
                onTap: () {
                  widget.cubit.selectTypeNhiemVuSubject.add([true,false, false]);
                  widget.cubit.emit(NhiemVuCaNhan());
                  Navigator.pop(context);
                },
                isSelect: data[0],
              ),
              const SizedBox(
                height: 20,
              ),
              ItemMenuNhiemVuWidgetTablet(
                isShowNumber: false,
                icon: ImageAssets.icDonViNhiemVu,
                name: S.current.nhiem_vu_don_vi,
                number: 20,
                onTap: () {
                  widget.cubit.selectTypeNhiemVuSubject.add([false, true,false]);
                  widget.cubit.emit(NhiemVuDonVi());
                  Navigator.pop(context);
                },
                isSelect: data[1],
              ),
              const SizedBox(
                height: 20,
              ),
              ItemMenuNhiemVuWidgetTablet(
                isShowNumber: false,
                icon: ImageAssets.icDonViNhiemVu,
                name: S.current.bao_cao_thong_ke,
                number: 20,
                onTap: () {
                  widget.cubit.selectTypeNhiemVuSubject.add([false,false, true]);
                  widget.cubit.emit(BaoCaoThongKe());
                  Navigator.pop(context);
                },
                isSelect: data[2],
              ),
            ],
          );
        },
      ),
    );
  }
}
