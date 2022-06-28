import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

enum StateType { CHO_XAC_NHAN, THAM_GIA, TU_CHOI }

class ItemMenuData {
  StateType type;
  int value;

  ItemMenuData(this.type, this.value);
}

// ignore: must_be_immutable
class PopUpMenu extends StatefulWidget {
  final Function(StateType) onChange;
  final List<ItemMenuData> data;
  ItemMenuData initData;

  PopUpMenu({
    Key? key,
    required this.onChange,
    required this.initData,
    required this.data,
  }) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSelect(
          context,
        );
      },
      child: Container(
        width: 140,
        key: _key,
        color: Colors.transparent,
        child: getMenuView(widget.initData, null),
      ),
    );
  }

  void showSelect(BuildContext context) {
    final box = _key.currentContext?.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return DialogSelectWidget(
          offset: position,
          currentItem: widget.initData,
          onDismiss: (item) {
            overlayEntry.remove();
            setState(() {
              widget.initData = item ?? widget.initData;
            });
            if (item != null){
              widget.onChange.call(item.type);
            }
          },
          data: widget.data,
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}

class DialogSelectWidget extends StatefulWidget {
  final Offset offset;
  final Function(ItemMenuData?) onDismiss;
  final List<ItemMenuData> data;
  final ItemMenuData currentItem;

  const DialogSelectWidget({
    Key? key,
    required this.offset,
    required this.onDismiss,
    required this.data,
    required this.currentItem,
  }) : super(key: key);

  @override
  State<DialogSelectWidget> createState() => _DialogSelectWidgetState();
}

class _DialogSelectWidgetState extends State<DialogSelectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _animationController.reverse().whenComplete(() {
                widget.onDismiss.call(null);
              });
            },
            child: SizedBox.expand(
              child: Container(
                color: Colors.transparent ,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: widget.offset.dy  ,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) => Opacity(
                opacity: _animationController.value,
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(
                      _animationController.value,
                      _animationController.value,
                    ),
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: borderColor.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: shadowContainerColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      children: widget.data
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                widget.onDismiss.call(e);
                              },
                              child: SizedBox(
                                width: 140,
                                  child: getMenuView(e, widget.currentItem)
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension GetViewByTypeMenu on StateType {
  Widget getMenuView(int value) {
    switch (this) {
      case StateType.CHO_XAC_NHAN:
        return ItemMenuView(
          title: S.current.cho_xac_nhan,
          color: color02C5DD,
          value: value,
        );

      case StateType.THAM_GIA:
        return ItemMenuView(
          title: S.current.tham_gia,
          color: itemWidgetUsing,
          value: value,
        );

      case StateType.TU_CHOI:
        return ItemMenuView(
          title: S.current.tu_choi,
          color: statusCalenderRed,
          value: value,
        );
    }
  }
}

Widget getMenuView(ItemMenuData dataItem ,ItemMenuData? itemSelect) {
  switch (dataItem.type) {
    case StateType.CHO_XAC_NHAN:
      return ItemMenuView(
        isSelect: itemSelect?.type == dataItem.type,
        title: S.current.cho_xac_nhan,
        color: color02C5DD,
        value: dataItem.value,
      );

    case StateType.THAM_GIA:
      return ItemMenuView(
        isSelect: itemSelect?.type == dataItem.type,
        title: S.current.tham_gia,
        color: itemWidgetUsing,
        value: dataItem.value,
      );

    case StateType.TU_CHOI:
      return ItemMenuView(
        isSelect: itemSelect?.type == dataItem.type,
        title: S.current.tu_choi,
        color: statusCalenderRed,
        value: dataItem.value,
      );
  }
}

class ItemMenuView extends StatelessWidget {
  const ItemMenuView({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
     this.isSelect = false,
  }) : super(key: key);

  final String title;
  final Color color;
  final int value;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: isSelect ? color: null,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title($value)',
            style: textNormalCustom(
              color: isSelect ? Colors.white: color ,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
