import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoChiMangXaHoiMenu extends StatefulWidget {
  final BaoChiMangXaHoiBloc cubit;
  final Function() onChange;

  const BaoChiMangXaHoiMenu(
      {Key? key, required this.cubit, required this.onChange})
      : super(key: key);

  @override
  _BaoChiMangXaHoiMenuState createState() => _BaoChiMangXaHoiMenuState();
}

class _BaoChiMangXaHoiMenuState extends State<BaoChiMangXaHoiMenu> {
  TheoDoiBaiVietCubit theoDoiBaiVietCubit = TheoDoiBaiVietCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      type: TypeContainer.expand,
                      childExpand: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.cubit.listSubMenu[index].length,
                        itemBuilder: (context, indexItem) {
                          return ContainerMenuBaoChiWidget(
                            name: widget
                                .cubit.listSubMenu[index][indexItem].title,
                            onTap: () {
                              widget.cubit.topic = widget
                                  .cubit.listSubMenu[index][indexItem].nodeId;
                              widget.onChange();
                              widget.cubit.slectColorItem(indexItem);
                              Navigator.pop(context);
                            },
                          );
                          // return GestureDetector(
                          //   child: StreamBuilder(
                          //     stream: widget.cubit.indexSelectItem,
                          //     builder: (context, snapshot) {
                          //       final data = snapshot.data;
                          //       return Container(
                          //         // color: data == indexItem
                          //         //     ? linkColor
                          //         //     : backgroundColorApp,
                          //         // padding: const EdgeInsets.fromLTRB(
                          //         //   32,
                          //         //   0,
                          //         //   0,
                          //         //   16,
                          //         // ),
                          //         child: Text(
                          //           widget.cubit.listSubMenu[index][indexItem]
                          //               .title,
                          //           style: tokenDetailAmount(
                          //             color: textTitle,
                          //             fontSize: 14.0.textScale(),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          //   onTap: () {
                          //     widget.cubit.topic = widget
                          //         .cubit.listSubMenu[index][indexItem].nodeId;
                          //     widget.onChange();
                          //     widget.cubit.slectColorItem(indexItem);
                          //     Navigator.pop(context);
                          //   },
                          // );
                        },
                      ),
                      onTap: () {
                        widget.cubit.topic =
                            widget.cubit.listTitleItemMenu[index].nodeId;
                        widget.onChange();
                      },
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
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
