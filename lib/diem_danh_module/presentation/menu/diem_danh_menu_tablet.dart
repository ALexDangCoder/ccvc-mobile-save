import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/ui/type_diem_danh/type_diem_danh.dart';
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
  List<TypeDiemDanh> itemMenu = [
    TypeDiemDanh.CA_NHAN,
    TypeDiemDanh.KHUON_MAT,
    TypeDiemDanh.BIEN_SO_XE,
  ];

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
      body: StreamBuilder<TypeDiemDanh>(
        stream: widget.cubit.typeDiemDanhStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? TypeDiemDanh.CA_NHAN;
          return Column(
            children: itemMenu
                .map(
                  (e) => Column(
                    children: [
                      e.getItemMenuTablet(
                        type: e,
                        selectType: data,
                        onTap: () {
                          widget.cubit.typeDiemDanhSubject.add(
                            e,
                          );
                          Navigator.pop(context);
                        },
                      ),
                      spaceH20,
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
