import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
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
      backgroundColor: backgroundDrawerMenu,
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
                    padding: const EdgeInsets.only(bottom: 12),
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
            const Divider(
              color: containerColor,
              height: 1,
            ),
            spaceH12,
            ...dataMenu
                .map(
                  (e) => e.childData != null
                      ? menuItemWithChild(e, context)
                      : menuViewNoChild(e , context),
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
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 12,
        ),
        color: Colors.transparent,
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
                        color: backgroundColorApp,
                        fontSize: 14,
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
        color: AppTheme.getInstance().colorField(),
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: textNormalCustom(
          color: backgroundColorApp,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget get title => Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          if (isLichHop)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.getInstance().colorField(),
              ),
              child: SvgPicture.asset(ImageAssets.icChonPhongHop, color: backgroundColorApp,),
            )
          else
            SvgPicture.asset(ImageAssets.icHeaderLVVV.svgToTheme()),
          const SizedBox(
            width: 12,
          ),
          Text(
            isLichHop ? S.current.menu_lich_hop : S.current.lich_lam_viec,
            style: textNormalCustom(
              color: backgroundColorApp,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );

  Widget itemMenuView({
    bool isSelect = false,
    required String icon,
    required String title,
    Function()? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 10,
        ),
        color: isSelect ? color_464646 : null,
        child: Row(
          children: [
            SizedBox(
              height: 15,
              width: 15,
              child: SvgPicture.asset(
                icon,
              ),
            ),
            spaceW13,
            Expanded(
              child: Text(
                title,
                style: textNormalCustom(
                  color: backgroundColorApp,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuViewNoChild(ParentMenu item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Expanded(
            child: itemMenuView(
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
          spaceW18,
        ],
      ),
    );
  }

  Widget menuItemWithChild(ParentMenu item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: ExpandOnlyWidget(
        isPaddingIcon: true,
        header: itemMenuView(
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

class ChildMenu {
  String title;
  int count;
  DataItemMenu value;

  ChildMenu({required this.title, required this.count, required this.value});

}

class StateMenu {
  String title;
  String icon;
  BaseState state;

  StateMenu({
    required this.title,
    required this.icon,
    required this.state,
  });
}

class ParentMenu {
  String title;
  int count;
  String iconAsset;
  DataItemMenu? value;
  List<ChildMenu>? childData;

  ParentMenu({
    required this.title,
    required this.count,
    required this.iconAsset,
    this.value,
    this.childData,
  });
}

abstract class DataItemMenu {}

class StatusDataItem extends DataItemMenu {
  StatusWorkCalendar value;

  StatusDataItem(this.value);
}

class LeaderDataItem extends DataItemMenu {
  String id;
  String title;

  LeaderDataItem(this.id, this.title);
}
