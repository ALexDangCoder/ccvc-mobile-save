import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:flutter/material.dart';

class StatePhatBieuWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const StatePhatBieuWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _StatePhatBieuWidgetState createState() => _StatePhatBieuWidgetState();
}

class _StatePhatBieuWidgetState extends State<StatePhatBieuWidget>
    with SingleTickerProviderStateMixin {
  bool expand = false;
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<ButtonStatePhatBieu>(
            stream: widget.cubit.buttonStatePhatBieuSubject,
            builder: (context, snapshot) {
              final data = snapshot.data ??  widget.cubit.buttonStatePhatBieu.first;
              return StreamBuilder<SoLuongPhatBieuModel>(
                  stream: widget.cubit.dataSoLuongPhatBieuSubject,
                builder: (context, snapshot) {
                  return buttonPhone(
                    key: data.key ?? '',
                    value: data.value.toString(),
                    color: data.color ?? Colors.white,
                    ontap: () {
                      /// reset list when change list
                      widget.cubit.selectPhatBieu = [];
                      expand = !expand;
                      _runExpandCheck();
                    },
                  );
                }
              );
            },
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: StreamBuilder<int>(
                stream: widget.cubit.typeStatus,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: toDayColor),
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.cubit.buttonStatePhatBieu.length,
                        itemBuilder: (context, index) {
                          final data = widget.cubit.buttonStatePhatBieu;
                          return StreamBuilder<SoLuongPhatBieuModel>(
                              stream: widget.cubit.dataSoLuongPhatBieuSubject,
                              builder: (context, snapshotCount) {
                                return buttonPhone(
                                  backgroup: widget.cubit
                                      .bgrColorButton(snapshot.data ?? 0),
                                  key: data[index].key ?? '',
                                  value: data[index].value.toString(),
                                  color: data[index].color ?? Colors.white,
                                  ontap: () {
                                    widget.cubit.getValueStatus(index);
                                    expand = !expand;
                                    _runExpandCheck();
                                    widget.cubit.buttonStatePhatBieuSubject.sink
                                        .add(
                                      ButtonStatePhatBieu(
                                        key: data[index].key ?? '',
                                        value: data[index].value ?? 0,
                                        color:
                                            data[index].color ?? Colors.white,
                                      ),
                                    );
                                    widget.cubit.selectPhatBieu.clear();
                                  },
                                );
                              });
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget buttonPhone({
  required String key,
  required String value,
  required Color color,
  required Function() ontap,
  Color backgroup = backgroundColorApp,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Row(
      children: [
        Container(
          margin:
              isMobile() ? const EdgeInsets.only(bottom: 16) : EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: backgroup == color ? backgroup : backgroundColorApp,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            border: Border.all(
              color: color,
            ),
          ),
          child: Text(
            '$key ($value)',
            style: textNormalCustom(
              color: color == backgroup ? backgroundColorApp : color,
            ),
          ),
        ),
        if (isMobile()) const Expanded(child: SizedBox()),
      ],
    ),
  );
}
