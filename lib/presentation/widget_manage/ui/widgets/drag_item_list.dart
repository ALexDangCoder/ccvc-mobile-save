import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/drag_widget_item.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DragItemList extends StatefulWidget {
  final List<WidgetModel> listWidget;
  final WidgetManageCubit widgetManageCubit;
  final bool isUsing;
  final Function(double scrollPosision) scrollCallBack;
  const DragItemList({
    required this.listWidget,
    required this.widgetManageCubit,
    required this.isUsing,
    required this.scrollCallBack,
    Key? key,
  }) : super(key: key);

  @override
  _DragItemListState createState() => _DragItemListState();
}

class _DragItemListState extends State<DragItemList> {
  final ScrollController scrollController=ScrollController();
  final GlobalKey globalKey=GlobalKey();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.widgetManageCubit.listUpdate,
      builder: (index, snapshot) {
        return _createListener( ReorderableListView.builder(
          key: globalKey,
          scrollController: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          buildDefaultDragHandles: widget.isUsing,
          proxyDecorator: (_, index, ___) {
            final String productName = widget.listWidget[index].name;
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
                    content: productName,
                  ),
                ),
              ),
            );
          },
          itemCount: widget.listWidget.length,
          itemBuilder: (context, index) {
            final String productName = widget.listWidget[index].name;
            return Padding(
              key: ValueKey(productName),
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
                content: productName,
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
        ),);
      },
    );
  }

  Widget _createListener(Widget child) {
    return Listener(
      child: child,
      onPointerMove: (PointerMoveEvent event) {
        double posision=0;
        final RenderBox render =
            globalKey.currentContext?.findRenderObject() as RenderBox;
        final Offset position = render.localToGlobal(Offset.zero);
        final double topY = position.dy; // top position of the widget
        final double bottomY =
            topY + render.size.height; // bottom position of the widget
        const detectedRange = 100;
        const moveDistance = 3;
        if (event.position.dy < topY + detectedRange) {
          print('------------------- call back posision-----------------');
          var to = scrollController.offset - moveDistance;
          to = (to < 0) ? 0 : to;
          posision=to;
          // scrollController.jumpTo(to);
          widget.scrollCallBack(posision);
        }
        if (event.position.dy > bottomY - detectedRange) {
          print('------------------- call back posision-----------------');
          posision=scrollController.offset+ moveDistance;
          // scrollController.jumpTo(scrollController.offset + moveDistance);
          widget.scrollCallBack(posision);
        }
      },
    );
  }
}
