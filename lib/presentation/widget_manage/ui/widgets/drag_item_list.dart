import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/drag_widget_item.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_drop_drap_listview.dart';

class DragItemList extends StatefulWidget {
  final List<WidgetModel> listWidget;
  final WidgetManageCubit widgetManageCubit;
  final bool isUsing;
  final Widget headerList;
  final Widget footerList;
  final bool isScroll;
  final bool paddingTablet;

  const DragItemList({
    required this.listWidget,
    required this.widgetManageCubit,
    required this.headerList,
    required this.footerList,
    this.isScroll = false,
    required this.isUsing,
    this.paddingTablet = false,
    Key? key,
  }) : super(key: key);

  @override
  _DragItemListState createState() => _DragItemListState();
}

class _DragItemListState extends State<DragItemList> {
  final UniqueKey uniqueKey = UniqueKey();

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.paddingTablet ? 0 : 16),
      child: CustomReorderableListView.builder(
        shrinkWrap: true,
        physics: widget.isScroll
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        header: widget.headerList,
        footer: widget.footerList,
        buildDefaultDragHandles: widget.isUsing,
        proxyDecorator: (_, index, ___) {
          final String widgetName =
              widget.widgetManageCubit.getNameWidget(widget.listWidget[index]);
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: WidgetItem(
                  clickICon: () {},
                  widgetIcon: widget.isUsing
                      ? SvgPicture.asset(ImageAssets.icClose)
                      : SvgPicture.asset(ImageAssets.icAdd),
                  backgroundColor: widget.isUsing
                      ? itemWidgetUsing.withOpacity(0.04)
                      : itemWidgetNotUse.withOpacity(0.05),
                  borderColor: widget.isUsing
                      ? itemWidgetUsing.withOpacity(0.3)
                      : itemWidgetNotUse.withOpacity(0.3),
                  content: widgetName,
                ),
              ),
            ),
          );
        },
        itemCount: widget.listWidget.length,
        itemBuilder: (context, index) {
          final String widgetName =
              widget.widgetManageCubit.getNameWidget(widget.listWidget[index]);
          return Padding(
            key: ValueKey(widgetName),
            padding: const EdgeInsets.only(bottom: 20),
            child: WidgetItem(
              widgetIcon: widget.isUsing
                  ? SvgPicture.asset(ImageAssets.icClose)
                  : SvgPicture.asset(ImageAssets.icAdd),
              backgroundColor: widget.isUsing
                  ? itemWidgetUsing.withOpacity(0.04)
                  : itemWidgetNotUse.withOpacity(0.05),
              borderColor: widget.isUsing
                  ? itemWidgetUsing.withOpacity(0.3)
                  : itemWidgetNotUse.withOpacity(0.3),
              content: widgetName,
              clickICon: () {
                widget.isUsing
                    ? widget.widgetManageCubit.insertItemNotUse(
                        widget.listWidget[index],
                        index,
                      )
                    : widget.widgetManageCubit.insertItemUsing(
                        widget.listWidget[index],
                        index,
                      );
                widget.widgetManageCubit.setParaUpdateWidget();
                widget.widgetManageCubit.updateListWidget(
                  widget.widgetManageCubit.listResponse.toString(),
                );
              },
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
            widget.widgetManageCubit.sortListWidget(
              oldIndex,
              newIndex,
            );
          });
        },
      ),
    );
  }
}
