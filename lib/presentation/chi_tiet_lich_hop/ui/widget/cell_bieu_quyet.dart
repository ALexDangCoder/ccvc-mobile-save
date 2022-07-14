import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/sua_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late DateTime start;

  late DateTime end;

  late DateTime timeDate;

  late CountdownTimerController startCountdownController;
  late CountdownTimerController endCountdownController;

  @override
  void initState() {
    super.initState();
    start = DateFormat(DateTimeFormat.DATE_TIME_HHT)
        .parse(widget.infoModel.thoiGianBatDau ?? '');
    end = DateFormat(DateTimeFormat.DATE_TIME_HHT)
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
    widget.infoModel.idPhienHopCanBo = widget.cubit.idPhienHop;
    widget.cubit.danhSachLuaChon = [];
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        S.current.ten_bieu_quyet,
                        style: textNormalCustom(
                          fontSize: 14,
                          color: color667793,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceW20,
                    Expanded(
                      flex: 6,
                      child: Text(
                        ' ${widget.infoModel.noiDung}',
                        style: textNormalCustom(
                          fontSize: 16,
                          color: infoColor,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                spaceH10,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        S.current.thoi_gian,
                        style: textNormalCustom(
                          fontSize: 14,
                          color: color667793,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceW20,
                    Expanded(
                      flex: 6,
                      child: Text(
                        '${coverDateTime(widget.infoModel.thoiGianBatDau ?? '')} - '
                        '${coverDateTime(widget.infoModel.thoiGianKetThuc ?? '')}',
                        style: textNormalCustom(
                          fontSize: 16,
                          color: infoColor,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                spaceH10,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        S.current.thoi_gian_bq,
                        style: textNormalCustom(
                          fontSize: 14,
                          color: color667793,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceW20,
                    if (widget.cubit.isNotStartYet(
                      startTime: timeDate,
                    )) ...[
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 10,
                          ),
                          child: Text(
                            TIME,
                            style: textNormalCustom(
                              color: canceledColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ] else ...[
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: CountdownTimer(
                            controller: endCountdownController,
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              if (time == null) {
                                return Text(
                                  TIME,
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
                      ),
                    ],
                  ],
                ),
                spaceH10,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        S.current.loai_bieu_quyet,
                        style: textNormalCustom(
                          fontSize: 14,
                          color: color667793,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceW20,
                    Expanded(
                      flex: 6,
                      child: Text(
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
                    ),
                  ],
                ),
                spaceH10,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        S.current.danh_sach_lua_chon,
                        style: textNormalCustom(
                          fontSize: 14,
                          color: color667793,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceW20,
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              widget.infoModel.danhSachKetQuaBieuQuyet
                                      ?.length ??
                                  0, (index) {
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
                                onTap: () async {
                                  await widget.cubit.themMoiVote(
                                    lichHopId: widget.cubit.idCuocHop,
                                    bieuQuyetId: widget.infoModel.id ?? '',
                                    donViId: HiveLocal.getDataUser()
                                            ?.userInformation
                                            ?.donViTrucThuoc
                                            ?.id ??
                                        '',
                                    canBoId: HiveLocal.getDataUser()?.userId,
                                    luaChonBietQuyetId: widget
                                            .infoModel
                                            .danhSachKetQuaBieuQuyet?[index]
                                            .luaChonId ??
                                        '',
                                    idPhienhopCanbo:
                                        widget.cubit.checkIdPhienHop(
                                      widget.infoModel.idPhienHopCanBo,
                                    ),
                                  );
                                },
                                isVote: widget
                                        .infoModel
                                        .danhSachKetQuaBieuQuyet?[index]
                                        .isVote ??
                                    true,
                                cubit: widget.cubit,
                              ),
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              right: 5,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showBottomSheetCustom(
                        context,
                        title: S.current.sua_bieu_quyet,
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: SuaBieuQuyetWidget(
                            idBieuQuyet: widget.infoModel.id ?? '',
                            cubit: widget.cubit,
                          ),
                        ),
                      ).then((value) {
                        if (value == null) {
                          return;
                        }
                        if (value) {
                          widget.cubit.callApi(widget.cubit.idCuocHop, '');
                        }
                      });
                    },
                    child: SvgPicture.asset(ImageAssets.ic_edit),
                  ),
                  spaceW10,
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(ImageAssets.ic_delete_do),
                  )
                ],
              ),
            )
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          S.current.ten_bieu_quyet,
                          style: textNormalCustom(
                            fontSize: 14,
                            color: color667793,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW20,
                      Expanded(
                        flex: 6,
                        child: Text(
                          ' ${widget.infoModel.noiDung}',
                          style: textNormalCustom(
                            fontSize: 16,
                            color: infoColor,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  spaceH10,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          S.current.thoi_gian,
                          style: textNormalCustom(
                            fontSize: 14,
                            color: color667793,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW20,
                      Expanded(
                        flex: 6,
                        child: Text(
                          '${coverDateTime(widget.infoModel.thoiGianBatDau ?? '')} '
                          '- '
                          '${coverDateTime(widget.infoModel.thoiGianKetThuc ?? '')}',
                          style: textNormalCustom(
                            fontSize: 16,
                            color: infoColor,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  spaceH10,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          S.current.thoi_gian_bq,
                          style: textNormalCustom(
                            fontSize: 14,
                            color: color667793,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW20,
                      if (widget.cubit.isNotStartYet(
                        startTime: timeDate,
                      )) ...[
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 10,
                            ),
                            child: Text(
                              TIME,
                              style: textNormalCustom(
                                color: canceledColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ] else ...[
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: CountdownTimer(
                              controller: endCountdownController,
                              widgetBuilder: (_, CurrentRemainingTime? time) {
                                if (time == null) {
                                  return Text(
                                    TIME,
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
                        ),
                      ],
                    ],
                  ),
                  spaceH10,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          S.current.loai_bieu_quyet,
                          style: textNormalCustom(
                            fontSize: 14,
                            color: color667793,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW20,
                      Expanded(
                        flex: 6,
                        child: Text(
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
                      ),
                    ],
                  ),
                  spaceH10,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          S.current.danh_sach_lua_chon,
                          style: textNormalCustom(
                            fontSize: 14,
                            color: color667793,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW20,
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                widget.infoModel.danhSachKetQuaBieuQuyet
                                        ?.length ??
                                    0, (index) {
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
                                  onTap: () async {
                                    await widget.cubit.themMoiVote(
                                      lichHopId: widget.cubit.idCuocHop,
                                      bieuQuyetId: widget.infoModel.id ?? '',
                                      donViId: HiveLocal.getDataUser()
                                              ?.userInformation
                                              ?.donViTrucThuoc
                                              ?.id ??
                                          '',
                                      canBoId: HiveLocal.getDataUser()?.userId,
                                      luaChonBietQuyetId: widget
                                              .infoModel
                                              .danhSachKetQuaBieuQuyet?[index]
                                              .luaChonId ??
                                          '',
                                      idPhienhopCanbo:
                                          widget.cubit.checkIdPhienHop(
                                        widget.infoModel.idPhienHopCanBo,
                                      ),
                                    );
                                  },
                                  isVote: widget
                                          .infoModel
                                          .danhSachKetQuaBieuQuyet?[index]
                                          .isVote ??
                                      true,
                                  cubit: widget.cubit,
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 5,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDiaLogTablet(
                          context,
                          title: S.current.sua_bieu_quyet,
                          child: SuaBieuQuyetWidget(
                            idBieuQuyet: widget.infoModel.id ?? '',
                            cubit: widget.cubit,
                          ),
                          isBottomShow: false,
                          funcBtnOk: () {
                            Navigator.pop(context);
                          },
                        ).then((value) {
                          if (value == true) {
                            widget.cubit.callAPiBieuQuyet();
                          } else if (value == null) {
                            return;
                          }
                        });
                      },
                      child: SvgPicture.asset(ImageAssets.ic_edit),
                    ),
                    spaceW10,
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(ImageAssets.ic_delete_do),
                    )
                  ],
                ),
              )
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
  final Function() onTap;
  final bool isVote;
  final DetailMeetCalenderCubit cubit;

  const ContainerState({
    Key? key,
    required this.number,
    required this.name,
    required this.onTap,
    required this.isVote,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.textScale(),
              vertical: 4.0.textScale(),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isVote ? colorLineSearch : AppTheme.getInstance().colorField(),
              border: Border.all(
                color: isVote ? colorLineSearch : AppTheme.getInstance().colorField(),
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
        ),
        Text(
          '$number',
          style: textNormalCustom(
            color: isVote ? colorLineSearch : AppTheme.getInstance().colorField(),
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
