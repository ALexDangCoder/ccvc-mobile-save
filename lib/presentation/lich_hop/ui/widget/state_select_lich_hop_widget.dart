import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/item_state_lich_duoc_moi.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

class StateSelectLichHopWidget extends StatefulWidget {
  final LichHopCubit cubit;

  const StateSelectLichHopWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<StateSelectLichHopWidget> createState() =>
      _StateSelectLichHopWidgetState();
}

class _StateSelectLichHopWidgetState extends State<StateSelectLichHopWidget>
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
      child: StreamBuilder<stateLDM>(
        stream: widget.cubit.getStateLDM.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? stateLDM.ChoXacNhan;
          return StreamBuilder<DashBoardLichHopModel>(
            stream: widget.cubit.dashBoardStream,
            builder: (context, snapshot) {
              return Container(
                key: _key,
                color: Colors.transparent,
                child: data.getState(
                  data.getIndexLichHop(
                    snapshot.data ?? DashBoardLichHopModel.empty(),
                  ),
                ),
              );
            },
          );
        },
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
  final LichHopCubit cubit;
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
                      color: colorFFFFFF,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: color6566E9.withOpacity(0.05),
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
                    child: StreamBuilder<DashBoardLichHopModel>(
                        stream: widget.cubit.dashBoardStream,
                        builder: (context, snapshot) {
                          final data =
                              snapshot.data ?? DashBoardLichHopModel.empty();
                          return Column(
                            children: [
                              getState(
                                state: stateLDM.ChoXacNhan,
                                index: data.soLichChoXacNhan ?? 0,
                              ),
                              getState(
                                state: stateLDM.ThamGia,
                                index: data.soLichThamGia ?? 0,
                              ),
                              getState(
                                state: stateLDM.TuChoi,
                                index: data.soLichChuTriTuChoi ?? 0,
                              ),
                            ],
                          );
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

  Widget getState({required stateLDM state, required int index}) {
    return GestureDetector(
      onTap: () {
        widget.cubit.getStateLDM.add(state);
        _animationController.reverse().whenComplete(() {
          widget.onDismis();
        });

        widget.cubit.listDSLH.clear();
        widget.cubit.page = 1;

        widget.cubit.postDanhSachLichHop();
      },
      child: state.getState(index),
    );
  }
}
