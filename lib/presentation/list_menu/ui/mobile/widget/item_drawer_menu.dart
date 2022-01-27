import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/list_menu/bloc/list_menu_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemDrawerMenu extends StatefulWidget {
  late String title;
  final String image;
  final ListMenuCubit cubit;
  final index;
  final Function(String)? onSelectItem;

  ItemDrawerMenu(this.cubit, this.image, this.title, this.index,
      {Key? key, this.onSelectItem})
      : super(key: key);

  @override
  State<ItemDrawerMenu> createState() => _ItemDrawerMenuState();
}

class _ItemDrawerMenuState extends State<ItemDrawerMenu> {
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
            SvgPicture.asset(widget.image),
            const SizedBox(
              width: 15,
            ),
            Text(
              widget.title,
              style: textNormalCustom(
                fontSize: 14.0.textScale(),
              ),
            ),
            const Expanded(child: SizedBox()),
            if (widget.cubit.menuItems[widget.index].badgeNumber == 0)
              const SizedBox()
            else
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  child: Text(
                    widget.cubit.menuItems[widget.index].badgeNumber.toString(),
                    style: const TextStyle(color: fontColor, fontSize: 12),
                  ),
                ),
              ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ),
    );
  }
}
