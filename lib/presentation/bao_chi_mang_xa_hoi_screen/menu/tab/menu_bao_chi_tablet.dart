
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuBaoChiTablet extends StatefulWidget {
  final BaoChiMangXaHoiBloc cubit;
  final Function() onChange;
  final int topic;

  const MenuBaoChiTablet({
    Key? key,
    required this.cubit,
    required this.onChange,
    required this.topic,
  }) : super(key: key);

  @override
  _MenuBaoChiTabletState createState() => _MenuBaoChiTabletState();
}

class _MenuBaoChiTabletState extends State<MenuBaoChiTablet> {
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
            const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 28),
        child: Column(
          children: [
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
                      return ContainerMenuBaoChiTabletWidget(
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
                            return ContainerMenuBaoChiTabletWidget(
                              selected: widget.topic ==
                                  widget.cubit.listSubMenu[index][indexItem]
                                      .nodeId,
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
                          widget.onChange();
                          widget.cubit.titleSubject.sink.add(
                            widget.cubit.listTitleItemMenu[index].title,
                          );
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
