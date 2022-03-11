import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/ket_noi_item_model.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/bloc/ket_noi_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/menu/ui/widget/container_ket_noi_tablet_menu.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KetNoiMenuTablet extends StatefulWidget {
  final KetNoiCubit cubit;

  const KetNoiMenuTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _KetNoiMenuTabletState createState() => _KetNoiMenuTabletState();
}

class _KetNoiMenuTabletState extends State<KetNoiMenuTablet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.hop,
        leadingIcon: IconButton(
          icon: SvgPicture.asset(
            ImageAssets.icExit,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: listKetNoi
                      .map(
                        (e) => ContainerKetNoiTablet(
                          name: e.typeMenu.getTitle(),
                          icon: e.icon,
                          type: e.type,
                          index: e.index ?? 0,
                          childExpand: Column(
                            children: e.typeMenu == TypeKetNoiMenu.SuKien
                                ? listSuKien
                                    .map(
                                      (e) => ContainerKetNoiTablet(
                                        icon: e.icon,
                                        name: e.typeMenu.getTitle(),
                                        index: e.index ?? 0,
                                        isIcon: false,
                                        onTap: () {
                                          e.onTap(context, widget.cubit);
                                        },
                                      ),
                                    )
                                    .toList()
                                : listKetNoi2
                                    .map(
                                      (e) => ContainerKetNoiTablet(
                                        icon: e.icon,
                                        name: e.typeMenu.getTitle(),
                                        index: e.index ?? 0,
                                        isIcon: false,
                                        onTap: () {
                                          e.onTap(context, widget.cubit);
                                        },
                                      ),
                                    )
                                    .toList(),
                          ),
                          onTap: () {
                            e.onTap(context, widget.cubit);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
