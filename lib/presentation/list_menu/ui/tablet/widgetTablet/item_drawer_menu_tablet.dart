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

  ItemDrawerMenuTablet(this.cubit, this.image, this.title, this.index,
      {Key? key})
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
                      top: BorderSide(color: color05OpacityDBDFEF),
                      bottom: BorderSide(color: color05OpacityDBDFEF),
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
                        ).copyWith(color: color3D5586, fontSize: 20),
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
                    border: Border.all(color: color05OpacityDBDFEF),
                    color: color01DBDFEF,
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
                        ).copyWith(color: color3D5586, fontSize: 20),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: colorECEAFF,
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
                              color: color3D5586,
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
