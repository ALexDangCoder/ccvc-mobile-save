import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuWidgetTablet extends StatelessWidget {
  const MenuWidgetTablet({
    Key? key,
    required this.dataMenu,
    required this.onChoose,
    required this.stateMenu,
    required this.state,
    this.isLichHop = false,
  }) : super(key: key);

  final List<ParentMenu> dataMenu;
  final List<StateMenu> stateMenu;
  final Function(DataItemMenu? value, BaseState state) onChoose;
  final BaseState state;
  final bool isLichHop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorApp,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH50,
            GestureDetector(
              child: title,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            spaceH24,
            ...stateMenu
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: itemMenuView(
                      icon: e.icon,
                      title: e.title,
                      onTap: () {
                        onChoose.call(null, e.state);
                        Navigator.of(context).pop();
                      },
                      isSelect: e.state == state,
                    ),
                  ),
                )
                .toList(),
            spaceH12,
            const Divider(
              color: containerColor,
              height: 1,
            ),
            spaceH28,
            ...dataMenu
                .map(
                  (e) => e.childData != null
                      ? menuItemWithChild(e, context)
                      : menuViewNoChild(e, context),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget childItemMenu(
    BuildContext context,
    ChildMenu data,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onChoose.call(data.value, state);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: borderColor.withOpacity(0.1),
        ),
        margin: const EdgeInsets.only(
          top: 16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  spaceW30,
                  Expanded(
                    child: Text(
                      data.title,
                      style: tokenDetailAmount(
                        color: color667793,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            spaceW12,
            countItemWidget(data.count),
          ],
        ),
      ),
    );
  }

  Widget countItemWidget(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: numberColorTabletbg,
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: textNormalCustom(
          color: AppTheme.getInstance().colorField(),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget get title => Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          SvgPicture.asset(
            ImageAssets.icX,
            height: 24,
            width: 24,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Center(
              child: Text(
                isLichHop
                    ? S.current.menu_lich_hop
                    : S.current.menu_lich_lam_viec,
                style: textNormalCustom(
                  color: color3D5586,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      );

  Widget itemMenuView({
    bool isSelect = false,
    required String icon,
    required String title,
    double padding = 30,
    Function()? onTap,
    bool haveBorder = true,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          border: haveBorder
              ? Border.all(color: borderColor.withOpacity(0.5))
              : null,
          color: isSelect ? AppTheme.getInstance().colorField() : null,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 26,
              width: 26,
              child: SvgPicture.asset(
                icon,
                color: isSelect
                    ? backgroundColorApp
                    : AppTheme.getInstance().colorField(),
              ),
            ),
            spaceW13,
            Expanded(
              child: Text(
                title,
                style: textNormalCustom(
                  color: isSelect ? backgroundColorApp : color3D5586,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuViewNoChild(ParentMenu item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 28,
        right: 28,
        bottom: 24,
      ),
      decoration: customDecoration,
      child: Row(
        children: [
          Expanded(
            child: itemMenuView(
              padding: 20,
              haveBorder: false,
              icon: item.iconAsset,
              title: item.title,
              onTap: () {
                Navigator.of(context).pop();
                onChoose.call(item.value, state);
              },
            ),
          ),
          spaceW12,
          countItemWidget(item.count),
          spaceW20,
        ],
      ),
    );
  }

  BoxDecoration get customDecoration => BoxDecoration(
        color: borderColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withOpacity(0.5)),
      );

  Widget menuItemWithChild(ParentMenu item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 28,
        right: 28,
        bottom: 24,
      ),
      child: ExpandOnlyWidget(
        headerDecoration: customDecoration,
        isPaddingIcon: true,
        header: itemMenuView(
          padding: 20,
          haveBorder: false,
          icon: item.iconAsset,
          title: item.title,
        ),
        child: Column(
          children: item.childData!
              .map(
                (e) => childItemMenu(
                  context,
                  e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
