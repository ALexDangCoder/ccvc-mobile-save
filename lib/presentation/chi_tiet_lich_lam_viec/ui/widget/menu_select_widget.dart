import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuSelectWidget extends StatefulWidget {
  final List<CellPopPupMenu> listSelect;
  final double paddingAll;

  const MenuSelectWidget({
    Key? key,
    required this.listSelect,
    this.paddingAll = 0.0,
  }) : super(key: key);

  @override
  State<MenuSelectWidget> createState() => _MenuSelectWidgetState();
}

class _MenuSelectWidgetState extends State<MenuSelectWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showSelect(context);
      },
      child: Container(
        padding: EdgeInsets.all(widget.paddingAll),
        key: _key,
        color: Colors.transparent,
        child: SvgPicture.asset(ImageAssets.icMenuDot),
      ),
    );
  }

  void showSelect(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final box = _key.currentContext?.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return DialogSelectWidget(
          offset: position,
          listSelect: widget.listSelect,
          onDismis: () {
            overlayEntry.remove();
          },
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}

class DialogSelectWidget extends StatefulWidget {
  final Offset offset;
  final Function() onDismis;
  final List<CellPopPupMenu> listSelect;

  const DialogSelectWidget({
    Key? key,
    required this.offset,
    required this.onDismis,
    required this.listSelect,
  }) : super(key: key);

  @override
  State<DialogSelectWidget> createState() => _DialogSelectWidgetState();
}

class _DialogSelectWidgetState extends State<DialogSelectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
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
                widget.onDismis();
              });
            },
            child: SizedBox.expand(
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width - widget.offset.dx,
            top: widget.offset.dy + 50,
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
                    width: 179,
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
                    padding: const EdgeInsets.only(right: 17, left: 17, top: 3),
                    child: Column(
                      children: List.generate(
                        widget.listSelect.length,
                        (index) => InkWell(
                          onTap: () {
                            widget.listSelect[index].onTap.call();
                            _animationController.reverse().whenComplete(() {
                              widget.onDismis();
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: selectCell(
                              widget.listSelect[index],
                              isShowBorder:
                                  index != widget.listSelect.length - 1,
                            ),
                          ),
                        ),
                      ),
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

  Widget selectCell(CellPopPupMenu qData, {bool isShowBorder = true}) {
    return Row(
      children: [
        SvgPicture.asset(
          qData.urlImage,
          color: qData.colorIcon,
        ),
        spaceW13,
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isShowBorder
                      ? borderColor.withOpacity(0.5)
                      : Colors.transparent,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              qData.text,
              style: textNormal(titleCalenderWork, 14.0.textScale()),
            ),
          ),
        )
      ],
    );
  }
}

class CellPopPupMenu {
  final String urlImage;
  final String text;
  final Color? colorIcon;
  final Function() onTap;

  CellPopPupMenu({
    required this.urlImage,
    required this.text,
    required this.onTap,
    this.colorIcon,
  });
}
