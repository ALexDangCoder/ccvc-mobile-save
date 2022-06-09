import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_state.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/widget_item_menu_diem_danh_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiemDanhMenuTablet extends StatefulWidget {
  final DiemDanhCubit cubit;

  const DiemDanhMenuTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _DiemDanhMenuTabletState createState() => _DiemDanhMenuTabletState();
}

class _DiemDanhMenuTabletState extends State<DiemDanhMenuTablet> {
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
      body: StreamBuilder<List<bool>>(
        stream: widget.cubit.selectTypeDiemDanhSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [true, false, false];
          return Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              ItemMenuDiemDanhWidgetTablet(
                isShowNumber: false,
                icon: ImageAssets.icDiemDanhCaNhan,
                number: 20,
                name: S.current.diem_danh_ca_nhan,
                onTap: () {
                  widget.cubit.selectTypeDiemDanhSubject
                      .add([true, false, false]);
                  widget.cubit.emit(DiemDanhCaNhan());
                  Navigator.pop(context);
                },
                isSelect: data[0],
              ),
              const SizedBox(
                height: 20,
              ),
              ItemMenuDiemDanhWidgetTablet(
                isShowNumber: false,
                icon: ImageAssets.icDiemDanhKhuonMat,
                name: S.current.quan_ly_nhan_dien_khuon_mat,
                number: 20,
                onTap: () {
                  widget.cubit.selectTypeDiemDanhSubject
                      .add([false, true, false]);
                  widget.cubit.emit(DiemDanhKhuonMat());
                  Navigator.pop(context);
                },
                isSelect: data[1],
              ),
              const SizedBox(
                height: 20,
              ),
              ItemMenuDiemDanhWidgetTablet(
                isShowNumber: false,
                icon: ImageAssets.icDiemDanhBienSoXe,
                name: S.current.quan_ly_nhan_dien_bien_so_xe,
                number: 20,
                onTap: () {
                  widget.cubit.selectTypeDiemDanhSubject
                      .add([false, false, true]);
                  widget.cubit.emit(DiemDanhBienSoXe());
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
