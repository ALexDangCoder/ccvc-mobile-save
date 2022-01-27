import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/list_menu/bloc/list_menu_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemDrawerMenuTablet extends StatefulWidget {
  late String title;
  final String image;
  final ListMenuCubit cubit;
  final index;
  final Function(String)? onSelectItem;

  ItemDrawerMenuTablet(this.cubit, this.image, this.title, this.index,
      {Key? key, this.onSelectItem})
      : super(key: key);

  @override
  State<ItemDrawerMenuTablet> createState() => _ItemDrawerMenuTabletState();
}

class _ItemDrawerMenuTabletState extends State<ItemDrawerMenuTablet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onTap: () {
          widget.onSelectItem!(widget.title);
          Navigator.pop(context);
        },
        child: Row(
          children: [
            if (widget.cubit.menuItems[widget.index].badgeNumber == 0)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: cellColorborder),
                      bottom: BorderSide(color: cellColorborder),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(widget.image),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(),
                        ).copyWith(color: fontColorTablet2, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: cellColorborder),
                    color: cellColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(widget.image),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(),
                        ).copyWith(color: fontColorTablet2, fontSize: 20),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: numberColorTabletbg,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Text(
                            widget.cubit.menuItems[widget.index].badgeNumber
                                .toString(),
                            style: const TextStyle(
                              color: numberColorTablet,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
