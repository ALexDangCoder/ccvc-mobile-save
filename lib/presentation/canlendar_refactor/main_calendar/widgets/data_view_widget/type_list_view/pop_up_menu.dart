import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

enum StateType { CHO_XAC_NHAN, THAM_GIA, TU_CHOI }

class PopUpMenu extends StatefulWidget {
  final Function(StateType) onChange;
  final int soLichTuChoi;
  final int soLichThamGia;
  final int soLichChoXacNhan;

  const PopUpMenu({
    Key? key,
    required this.onChange,
    required this.soLichTuChoi,
    required this.soLichThamGia,
    required this.soLichChoXacNhan,
  }) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  final GlobalKey _key = GlobalKey();

  StateType stateType = StateType.CHO_XAC_NHAN;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSelect(
          context,
          (type) {
            setState(() {
              stateType = type;
            });
            widget.onChange.call(type);
          },
        );
      },
      child: Container(
        key: _key,
        color: Colors.transparent,
        child: Container (),
      ),
    );
  }

  void showSelect(BuildContext context, Function(StateType) onChange) {
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
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}

class DialogSelectWidget extends StatefulWidget {
  final Offset offset;
  final Function() onDismis;

  const DialogSelectWidget({
    Key? key,
    required this.offset,
    required this.onDismis,
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
          // GestureDetector(
          //   onTap: () {
          //     _animationController.reverse().whenComplete(() {
          //       widget.onDismis();
          //     });
          //   },
          //   child: SizedBox.expand(
          //     child: Container(
          //       color: Colors.transparent,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   right: MediaQuery.of(context).size.width - widget.offset.dx,
          //   top: widget.offset.dy + 50,
          //   child: AnimatedBuilder(
          //     animation: _animationController,
          //     builder: (context, _) => Opacity(
          //       opacity: _animationController.value,
          //       child: Transform(
          //         transform: Matrix4.identity()
          //           ..scale(
          //             _animationController.value,
          //             _animationController.value,
          //           ),
          //         alignment: Alignment.topRight,
          //         child: Container(
          //           width: isMobile() ? 200 : 230,
          //           decoration: BoxDecoration(
          //             color: backgroundColorApp,
          //             borderRadius: const BorderRadius.all(Radius.circular(12)),
          //             border: Border.all(color: borderColor.withOpacity(0.5)),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: shadowContainerColor.withOpacity(0.05),
          //                 blurRadius: 10,
          //                 offset: const Offset(0, 4),
          //               )
          //             ],
          //           ),
          //           padding: const EdgeInsets.only(
          //             right: 20,
          //             left: 20,
          //             top: 20,
          //           ),
          //           child: StreamBuilder<DashBoardLichHopModel>(
          //               stream: widget.cubit.lichLamViecDashBroadSubject.stream,
          //               builder: (context, snapshot) {
          //                 final data =
          //                     snapshot.data ?? DashBoardLichHopModel.empty();
          //                 return Column(
          //                   children: [
          //                     getState(
          //                       state: stateLDM.ChoXacNhan,
          //                       index: data.soLichChoXacNhan ?? 0,
          //                     ),
          //                     getState(
          //                       state: stateLDM.ThamGia,
          //                       index: data.soLichThamGia ?? 0,
          //                     ),
          //                     getState(
          //                       state: stateLDM.TuChoi,
          //                       index: data.soLichChuTriTuChoi ?? 0,
          //                     ),
          //                   ],
          //                 );
          //               }),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
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

class ItemMenuView extends StatelessWidget {
  const ItemMenuView({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;
  final int value;

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
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
