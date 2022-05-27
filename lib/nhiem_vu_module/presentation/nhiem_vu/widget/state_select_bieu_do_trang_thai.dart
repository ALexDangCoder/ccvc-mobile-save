import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/trang_thai_bieu_do_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/item_select_bieu_do.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

class StateSelectBieuDoTrangThaiWidget extends StatefulWidget {
  final DanhSachCubit cubit;

  const StateSelectBieuDoTrangThaiWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<StateSelectBieuDoTrangThaiWidget> createState() =>
      _StateSelectBieuDoTrangThaiWidgetState();
}

class _StateSelectBieuDoTrangThaiWidgetState
    extends State<StateSelectBieuDoTrangThaiWidget>
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
      onTap: () {
        showSelect(context);
      },
      child: Container(
        key: _key,
        child: const Icon(
          Icons.more_vert,
          color: textBodyTime,
        ),
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
          onDismis: () {
            overlayEntry.remove();
          },
          cubit: widget.cubit,
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}

class DialogSelectWidget extends StatefulWidget {
  final Offset offset;
  final DanhSachCubit cubit;
  final Function() onDismis;

  const DialogSelectWidget({
    Key? key,
    required this.offset,
    required this.onDismis,
    required this.cubit,
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
                    width: isMobile() ? 179 : 210,
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
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 20,
                    ),
                    child: StreamBuilder<List<ItemSellectBieuDo>>(
                        stream: widget.cubit.selectBieuDoModelSubject,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return Column(
                              children: data.map((e) => getState(e)).toList());
                        }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getState(ItemSellectBieuDo data) {
    return GestureDetector(
      onTap: () {
        final newData = widget.cubit.selectBieuDoModelSubject.valueOrNull ?? [];
        for (final ItemSellectBieuDo e in newData) {
          e.isCheck = false;
        }
        for (final ItemSellectBieuDo e in newData) {
          if (e.bieuDo == data.bieuDo) {
            e.isCheck = true;
          }
        }
        widget.cubit.selectBieuDoModelSubject.sink.add(newData);
        widget.cubit.getStateLDM.add(data.bieuDo);
        _animationController.reverse().whenComplete(() {
          widget.onDismis();
        });
      },
      child: data.bieuDo.getState(data.isCheck),
    );
  }
}
