import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'drag_widget_item.dart';

class ItemWidgetNotUse extends StatelessWidget {
  final WidgetManageCubit cubit;
  final String contentWidget;
  final int index;
  final WidgetModel widgetItem;

  const ItemWidgetNotUse({
    Key? key,
    required this.cubit,
    required this.contentWidget,
    required this.index,
    required this.widgetItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: WidgetItem(
        widgetIcon: SvgPicture.asset(ImageAssets.icAdd),
        backgroundColor: itemWidgetNotUse.withOpacity(0.05),
        borderColor: itemWidgetNotUse.withOpacity(0.3),
        content: contentWidget,
        clickICon: () {
          cubit.insertItemUsing(
            widgetItem,
            index,
          );
          cubit.setParaUpdateWidget();
          cubit.updateListWidget(
            cubit.listResponse.toString(),
          );
        },
      ),
    );
  }
}
