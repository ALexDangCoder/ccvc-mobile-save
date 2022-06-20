import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
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
      body: Column(
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
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.cubit.listTitleItemMenu.length,
                  itemBuilder: (context, index) {
                    return ContainerMenuBaoChiWidget(
                      name: widget.cubit.listTitleItemMenu[index].title,
                      icon: ImageAssets.icMenuItemBCMXH,
                      selected: widget.cubit.listSubMenu[index].isEmpty
                          ? initId ==
                                  widget.cubit.listTitleItemMenu[index].nodeId
                              ? true
                              : false
                          : false,
                      initExpand: initId ==
                          widget.cubit.listTitleItemMenu[index].nodeId,
                      type: widget.cubit.listSubMenu[index].isEmpty
                          ? TypeContainer.number
                          : TypeContainer.expand,
                      childExpand: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.cubit.listSubMenu[index].length,
                        itemBuilder: (context, indexItem) {
                          return ContainerMenuBaoChiWidget(
                            selected: widget.topic ==
                                widget
                                    .cubit.listSubMenu[index][indexItem].nodeId,
                            name: widget
                                .cubit.listSubMenu[index][indexItem].title,
                            onTap: () {
                              eventBus.fire(
                                FireTopic(
                                  widget.cubit.listSubMenu[index][indexItem]
                                      .nodeId,
                                ),
                              );
                              widget.cubit.titleSubject.sink.add(
                                widget.cubit.listTitleItemMenu[index].title,
                              );
                              widget.onChange();
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      onTap: widget.cubit.listSubMenu[index].isEmpty
                          ? () {
                              eventBus.fire(
                                FireTopic(
                                  widget.cubit.listTitleItemMenu[index].nodeId,
                                ),
                              );
                              widget.cubit.titleSubject.sink.add(
                                widget.cubit.listTitleItemMenu[index].title,
                              );
                              widget.onChange();
                              Navigator.pop(context);
                            }
                          : () {},
                    );
                  },
                ),
              ),
            ),
          )
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
