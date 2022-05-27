
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/tabbar_screen/ui/tabbar_item.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

class BottomTabBarWidget extends StatelessWidget {
  final int selectItemIndex;
  final Function(TabBarType) onChange;
  final Function(TabBarType) onDoubleTap;

  const BottomTabBarWidget({
    Key? key,
    required this.selectItemIndex,
    required this.onChange,
    required this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listItem = getTabListItem();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().dfBtnTxtColor(),
        border: const Border(top: BorderSide(color: fittingBg)),
      ),
      child: SafeArea(
        child: screenDevice(
          mobileScreen: Row(
            children: List.generate(listItem.length, (index) {
              final tab = listItem[index];

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    onChange(tab);
                  },
                  child: tabBarItem(
                    context: context,
                    item: tab,
                    isSelect: index == selectItemIndex,
                  ),
                ),
              );
            }),
          ),
          tabletScreen: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(listItem.length, (index) {
              final tab = listItem[index];

              return GestureDetector(
                onTap: () {
                  onChange(tab);
                },
                onDoubleTap: () {
                  onDoubleTap(tab);
                },
                child: tabBarItem(
                  context: context,
                  item: tab,
                  isSelect: index == selectItemIndex,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget tabBarItem({
    required BuildContext context,
    required TabBarType item,
    bool isSelect = false,
  }) {
    return screenDevice(
      mobileScreen: Container(
        color: Colors.transparent,
        height: 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            item.getTabBarItem(isSelect: isSelect).icon,
            FittedBox(
              child: Text(
                item.getTabBarItem().text,
                style: textNormal(
                  isSelect
                      ? AppTheme.getInstance().colorField()
                      : AppTheme.getInstance().buttonUnfocus(),
                  10,
                ),
              ),
            )
          ],
        ),
      ),
      tabletScreen: Container(
        height: 40,
        color: Colors.transparent,
        child: Row(
          children: [
            item.getTabBarItem(isSelect: isSelect).icon,
            spaceW13,
            FittedBox(
              child: Text(
                item.getTabBarItem().text,
                style: textNormal(
                  isSelect
                      ? AppTheme.getInstance().colorField()
                      : AppTheme.getInstance().buttonUnfocus(),
                  18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
