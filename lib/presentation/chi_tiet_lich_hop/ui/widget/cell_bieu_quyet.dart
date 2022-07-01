import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';

class CellBieuQuyet extends StatefulWidget {
  final DanhSachBietQuyetModel infoModel;
  final DetailMeetCalenderCubit cubit;

  const CellBieuQuyet({
    Key? key,
    required this.infoModel,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CellBieuQuyet> createState() => _CellBieuQuyetState();
}

class _CellBieuQuyetState extends State<CellBieuQuyet> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  DateTime? timeDate;

  late CountdownTimerController startCountdownController;
  late CountdownTimerController endCountdownController;

  @override
  void initState() {
    super.initState();
    start = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .parse(widget.infoModel.thoiGianBatDau ?? '');
    end = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .parse(widget.infoModel.thoiGianKetThuc ?? '');
    final startMillisec = start.millisecondsSinceEpoch;
    final endMillisec = end.millisecondsSinceEpoch;

    timeDate = DateTime.fromMillisecondsSinceEpoch(startMillisec);

    startCountdownController = CountdownTimerController(
      endTime: startMillisec,
    );

    endCountdownController = CountdownTimerController(
      endTime: endMillisec,
    );
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: borderItemCalender),
          color: borderItemCalender.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.ten_bieu_quyet,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.thoi_gian,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.thoi_gian_bq,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.loai_bieu_quyet,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.danh_sach_lua_chon,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            spaceW8,
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${widget.infoModel.noiDung}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  Text(
                    '${DateTime.parse(widget.infoModel.thoiGianBatDau ?? '').formatApiListBieuQuyetMobile} - '
                    '${DateTime.parse(widget.infoModel.thoiGianKetThuc ?? '').formatApiFixMeet}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  if (widget.cubit.isNotStartYet(
                    startTime: timeDate ?? DateTime.now(),
                  )) ...[
                    Text(
                      '00:00:00',
                      style: textNormalCustom(
                        color: canceledColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: CountdownTimer(
                        controller: endCountdownController,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text(
                              '00:00:00',
                              style: textNormalCustom(
                                color: canceledColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          return Text(
                            '${widget.cubit.dateTimeCovert(time.hours ?? 0)}:'
                            '${widget.cubit.dateTimeCovert(time.min ?? 0)}:'
                            '${widget.cubit.dateTimeCovert(time.sec ?? 0)}',
                            style: textNormalCustom(
                              color: canceledColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  spaceH10,
                  Text(
                    loaiBieuQuyetFunc(
                      widget.infoModel.loaiBieuQuyet ?? true,
                    ),
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          widget.infoModel.danhSachKetQuaBieuQuyet?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ContainerState(
                            name: widget
                                    .infoModel
                                    .danhSachKetQuaBieuQuyet?[index]
                                    .tenLuaChon ??
                                '',
                            number: widget
                                    .infoModel
                                    .danhSachKetQuaBieuQuyet?[index]
                                    .soLuongLuaChon ??
                                0,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderItemCalender),
            color: borderItemCalender.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.ten_bieu_quyet,
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.thoi_gian,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.thoi_gian_bq,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.loai_bieu_quyet,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.danh_sach_lua_chon,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.infoModel.noiDung}',
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                ),
                              ),
                              spaceH16,
                              Text(
                                '${DateTime.parse(widget.infoModel.thoiGianBatDau ?? '').formatApiListBieuQuyetMobile} - '
                                '${DateTime.parse(widget.infoModel.thoiGianKetThuc ?? '').formatApiFixMeet}',
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH14,
                              if (widget.cubit.isNotStartYet(
                                startTime: timeDate ?? DateTime.now(),
                              )) ...[
                                Text(
                                  '00:00:00',
                                  style: textNormalCustom(
                                    color: canceledColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ] else ...[
                                CountdownTimer(
                                  controller: endCountdownController,
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return Text(
                                        '00:00:00',
                                        style: textNormalCustom(
                                          color: canceledColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    }
                                    return Text(
                                      '${widget.cubit.dateTimeCovert(time.hours ?? 0)}:'
                                      '${widget.cubit.dateTimeCovert(time.min ?? 0)}:'
                                      '${widget.cubit.dateTimeCovert(time.sec ?? 0)}',
                                      style: textNormalCustom(
                                        color: canceledColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                              ],
                              spaceH14,
                              Text(
                                loaiBieuQuyetFunc(
                                  widget.infoModel.loaiBieuQuyet ?? true,
                                ),
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH14,
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.infoModel
                                      .danhSachKetQuaBieuQuyet?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: ContainerState(
                                        name: widget
                                                .infoModel
                                                .danhSachKetQuaBieuQuyet?[index]
                                                .tenLuaChon ??
                                            '',
                                        number: widget
                                                .infoModel
                                                .danhSachKetQuaBieuQuyet?[index]
                                                .soLuongLuaChon ??
                                            0,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerState extends StatelessWidget {
  final int number;
  final String name;

  const ContainerState({
    Key? key,
    required this.number,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0.textScale(),
            vertical: 4.0.textScale(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: textDefault,
            border: Border.all(
              color: textDefault,
            ),
          ),
          child: Text(
            name,
            style: textNormalCustom(
              color: backgroundColorApp,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        spaceH6,
        Text(
          '$number',
          style: textNormalCustom(
            color: textDefault,
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
