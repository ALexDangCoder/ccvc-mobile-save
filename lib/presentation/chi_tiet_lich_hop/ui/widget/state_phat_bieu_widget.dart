import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  late AnimationController expandController;
  late Animation<double> animation;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _iconTurns = expandController.drive(_halfTween.chain(_easeInTween));
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
          GestureDetector(
            onTap: () {
              expand = !expand;
              _runExpandCheck();
            },
<<<<<<< HEAD
            child: (widget.cubit.typeStatus.value ==
                    widget.cubit.danhSachphatBieu)
=======
            child: (widget.cubit.typeStatus.value == widget.cubit.danhSachphatBieu)
>>>>>>> develop
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: choXuLyColor),
                    ),
                    child: Text(
                      '${S.current.danh_sach_phat_bieu} (${widget.cubit.dataSoLuongPhatBieu.danhSachPhatBieu})',
                      style: textNormalCustom(
                        color: choXuLyColor,
                      ),
                    ),
                  )
                : (widget.cubit.typeStatus.value == widget.cubit.choDuyet
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(color: itemWidgetNotUse),
                        ),
                        child: Text(
                          '${S.current.cho_duyet} (${widget.cubit.dataSoLuongPhatBieu.choDuyet})',
                          style: textNormalCustom(
                            color: itemWidgetNotUse,
                          ),
                        ),
                      )
                    : (widget.cubit.typeStatus.value == widget.cubit.daDuyet
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: backgroundColorApp,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: itemWidgetUsing),
                            ),
                            child: Text(
                              '${S.current.da_duyet} (${widget.cubit.dataSoLuongPhatBieu.daDuyet})',
                              style: textNormalCustom(
                                color: itemWidgetUsing,
                              ),
                            ),
                          )
<<<<<<< HEAD
                        : (widget.cubit.typeStatus.value ==
                                widget.cubit.huyDuyet
=======
                        : (widget.cubit.typeStatus.value == widget.cubit.huyDuyet
>>>>>>> develop
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: backgroundColorApp,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  border: Border.all(color: statusCalenderRed),
                                ),
                                child: Text(
                                  '${S.current.huy_duyet} (${widget.cubit.dataSoLuongPhatBieu.huyDuyet})',
                                  style: textNormalCustom(
                                    color: statusCalenderRed,
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: backgroundColorApp,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  border: Border.all(color: choXuLyColor),
                                ),
                                child: Text(
                                  '${S.current.danh_sach_phat_bieu} (${widget.cubit.dataSoLuongPhatBieu.danhSachPhatBieu})',
                                  style: textNormalCustom(
                                    color: choXuLyColor,
                                  ),
                                ),
                              )))),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: backgroundColorApp,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: toDayColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.cubit.getValueStatus(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(color: choXuLyColor),
                        ),
                        child: Text(
                          '${S.current.danh_sach_phat_bieu} (${widget.cubit.dataSoLuongPhatBieu.danhSachPhatBieu})',
                          style: textNormalCustom(
                            color: choXuLyColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        widget.cubit.getValueStatus(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(color: itemWidgetNotUse),
                        ),
                        child: Text(
                          '${S.current.cho_duyet} (${widget.cubit.dataSoLuongPhatBieu.choDuyet})',
                          style: textNormalCustom(
                            color: itemWidgetNotUse,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        widget.cubit.getValueStatus(3);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(color: itemWidgetUsing),
                        ),
                        child: Text(
                          '${S.current.da_duyet} (${widget.cubit.dataSoLuongPhatBieu.daDuyet})',
                          style: textNormalCustom(
                            color: itemWidgetUsing,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        widget.cubit.getValueStatus(4);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(color: statusCalenderRed),
                        ),
                        child: Text(
                          '${S.current.huy_duyet} (${widget.cubit.dataSoLuongPhatBieu.huyDuyet})',
                          style: textNormalCustom(
                            color: statusCalenderRed,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
