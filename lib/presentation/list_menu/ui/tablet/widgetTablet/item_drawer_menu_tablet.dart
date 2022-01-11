import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/list_menu/bloc/list_menu_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemDrawerMenuTablet extends StatelessWidget {
  late String title;
  final String image;
  final ListMenuCubit cubit;
  final index;

  ItemDrawerMenuTablet(this.cubit, this.image, this.title, this.index,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            SvgPicture.asset(image),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: textNormalCustom(
                fontSize: 14.0.textScale(),
              ).copyWith(color: fontColorTablet2, fontSize: 20),
            ),
            const Expanded(child: SizedBox()),
            if (cubit.menuItems[index].badgeNumber == 0)
              const SizedBox()
            else
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: numberColorTabletbg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.all(4),
                  child: Text(
                    cubit.menuItems[index].badgeNumber.toString(),
                    style:
                        const TextStyle(color: numberColorTablet, fontSize: 14),
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
