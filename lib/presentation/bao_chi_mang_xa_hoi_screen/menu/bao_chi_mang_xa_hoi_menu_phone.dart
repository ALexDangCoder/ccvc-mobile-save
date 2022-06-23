import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoChiMangXaHoiMenu extends StatefulWidget {
  final BaoChiMangXaHoiBloc cubit;
  final Function() onChange;
  final int topic;

  const BaoChiMangXaHoiMenu({
    Key? key,
    required this.cubit,
    required this.onChange,
    required this.topic,
  }) : super(key: key);

  @override
  _BaoChiMangXaHoiMenuState createState() => _BaoChiMangXaHoiMenuState();
}

class _BaoChiMangXaHoiMenuState extends State<BaoChiMangXaHoiMenu> {
  TheoDoiBaiVietCubit theoDoiBaiVietCubit = TheoDoiBaiVietCubit();
  int initId = 848;

  @override
  void initState() {
    initId = widget.cubit.checkExpand(widget.topic).id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDrawerMenu,
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.cubit.stateStream,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 58,
            ),
            headerWidget(menu: S.current.baochi_mangxahoi),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: StreamBuilder<List<MenuData>>(
                    stream: widget.cubit.menuSubject.stream,
                    builder: (context, snapshot) {
                      final menuData = snapshot.data ?? [];
                      return snapshot.data != null
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: menuData.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<List<List<MenuItemModel>>>(
                                  stream: widget.cubit.menuItemSubject.stream,
                                  builder: (context, snapshot) {
                                    final menuItem = snapshot.data ?? [];
                                    return snapshot.data != null
                                        ? ContainerMenuBaoChiWidget(
                                            name: menuData[index].title,
                                            icon: ImageAssets.icMenuItemBCMXH,
                                            selected: menuItem[index].isEmpty
                                                ? initId ==
                                                        menuData[index].nodeId
                                                    ? true
                                                    : false
                                                : false,
                                            initExpand: initId ==
                                                menuData[index].nodeId,
                                            type: menuItem[index].isEmpty
                                                ? TypeContainer.number
                                                : TypeContainer.expand,
                                            childExpand: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: menuItem[index].length,
                                              itemBuilder:
                                                  (context, indexItem) {
                                                return snapshot.data != null
                                                    ? ContainerMenuBaoChiWidget(
                                                        selected: widget
                                                                .topic ==
                                                            menuItem[index]
                                                                    [indexItem]
                                                                .nodeId,
                                                        name: menuItem[index]
                                                                [indexItem]
                                                            .title,
                                                        onTap: () {
                                                          eventBus.fire(
                                                            FireTopic(
                                                              menuItem[index][
                                                                      indexItem]
                                                                  .nodeId,
                                                            ),
                                                          );
                                                          widget.cubit
                                                              .titleSubject.sink
                                                              .add(
                                                            menuData[index]
                                                                .title,
                                                          );
                                                          widget.onChange();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    : const SizedBox.shrink();
                                              },
                                            ),
                                            onTap: widget.cubit
                                                    .listSubMenu[index].isEmpty
                                                ? () {
                                                    eventBus.fire(
                                                      FireTopic(
                                                        menuData[index].nodeId,
                                                      ),
                                                    );
                                                    widget
                                                        .cubit.titleSubject.sink
                                                        .add(
                                                      menuData[index].title,
                                                    );
                                                    widget.onChange();
                                                    Navigator.pop(context);
                                                  }
                                                : () {},
                                          )
                                        : const SizedBox.shrink();
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            )
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
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
