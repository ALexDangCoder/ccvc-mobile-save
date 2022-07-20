import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/item_row_lua_chon.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/list_can_bo_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/sua_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CellBieuQuyetTablet extends StatefulWidget {
  final DanhSachBietQuyetModel infoModel;
  final DetailMeetCalenderCubit cubit;

  const CellBieuQuyetTablet({
    Key? key,
    required this.infoModel,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CellBieuQuyetTablet> createState() => _CellBieuQuyetTabletState();
}

class _CellBieuQuyetTabletState extends State<CellBieuQuyetTablet> {
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
    return Padding(
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
                        maxLines: 3,
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
                        '${coverDateTime(widget.infoModel.thoiGianBatDau ?? '')}'
                        ' - '
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
                        child: StreamBuilder<CanBoModel>(
                          stream: widget.cubit.isCheckDiemDanhSubject.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? CanBoModel();
                            return data.diemDanh == true &&
                                    data.trangThai == DA_THAM_GIA &&
                                    widget.cubit.compareEquaTime(
                                      widget.infoModel.thoiGianBatDau ?? '',
                                      widget.infoModel.thoiGianKetThuc ?? '',
                                    ) &&
                                    widget.cubit.compareTime(
                                      widget.infoModel.thoiGianKetThuc ?? '',
                                    )
                                ? Row(
                                    children: List.generate(
                                        widget.infoModel.danhSachKetQuaBieuQuyet
                                                ?.length ??
                                            0, (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: ItemRowLuaChon(
                                          name: widget
                                                  .infoModel
                                                  .danhSachKetQuaBieuQuyet?[
                                                      index]
                                                  .tenLuaChon ??
                                              '',
                                          number: widget
                                                  .infoModel
                                                  .danhSachKetQuaBieuQuyet?[
                                                      index]
                                                  .soLuongLuaChon ??
                                              0,
                                          onTap: () async {
                                            await widget.cubit.themMoiVote(
                                              lichHopId: widget.cubit.idCuocHop,
                                              bieuQuyetId:
                                                  widget.infoModel.id ?? '',
                                              donViId: HiveLocal.getDataUser()
                                                      ?.userInformation
                                                      ?.donViTrucThuoc
                                                      ?.id ??
                                                  '',
                                              canBoId: HiveLocal.getDataUser()
                                                  ?.userId,
                                              luaChonBietQuyetId: widget
                                                      .infoModel
                                                      .danhSachKetQuaBieuQuyet?[
                                                          index]
                                                      .luaChonId ??
                                                  '',
                                              idPhienhopCanbo:
                                                  widget.cubit.checkIdPhienHop(
                                                widget
                                                    .infoModel.idPhienHopCanBo,
                                              ),
                                            );
                                          },
                                          isVote: widget
                                                  .infoModel
                                                  .danhSachKetQuaBieuQuyet?[
                                                      index]
                                                  .isVote ??
                                              true,
                                          cubit: widget.cubit,
                                          onTapDanhSach: () {
                                            widget.infoModel.loaiBieuQuyet ==
                                                    true
                                                ? showDiaLogTablet(
                                                    context,
                                                    title: S.current
                                                        .danh_sach_lua_chon,
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxHeight:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.8,
                                                      ),
                                                      child:
                                                          DanhSachCanBoBieuQuyet(
                                                        cubit: widget.cubit,
                                                        luaChonId: widget
                                                                .infoModel
                                                                .danhSachKetQuaBieuQuyet?[
                                                                    index]
                                                                .luaChonId ??
                                                            '',
                                                        bieuQuyetId: widget
                                                                .infoModel.id ??
                                                            '',
                                                      ),
                                                    ),
                                                    funcBtnOk: () {},
                                                    isBottomShow: false,
                                                  )
                                                : Container();
                                          },
                                        ),
                                      );
                                    }),
                                  )
                                : Row(
                                    children: List.generate(
                                        widget.infoModel.danhSachKetQuaBieuQuyet
                                                ?.length ??
                                            0, (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: ItemRowLuaChonUnColor(
                                          name: widget
                                                  .infoModel
                                                  .danhSachKetQuaBieuQuyet?[
                                                      index]
                                                  .tenLuaChon ??
                                              '',
                                          number: widget
                                                  .infoModel
                                                  .danhSachKetQuaBieuQuyet?[
                                                      index]
                                                  .soLuongLuaChon ??
                                              0,
                                          onTap: () {},
                                          cubit: widget.cubit,
                                          onTapDanhSach: () {
                                            widget.infoModel.loaiBieuQuyet ==
                                                    true
                                                ? showDiaLogTablet(
                                                    context,
                                                    title: S.current
                                                        .danh_sach_lua_chon,
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxHeight:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.8,
                                                      ),
                                                      child:
                                                          DanhSachCanBoBieuQuyet(
                                                        cubit: widget.cubit,
                                                        luaChonId: widget
                                                                .infoModel
                                                                .danhSachKetQuaBieuQuyet?[
                                                                    index]
                                                                .luaChonId ??
                                                            '',
                                                        bieuQuyetId: widget
                                                                .infoModel.id ??
                                                            '',
                                                      ),
                                                    ),
                                                    funcBtnOk: () {},
                                                    isBottomShow: false,
                                                  )
                                                : Container();
                                          },
                                        ),
                                      );
                                    }),
                                  );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (widget.cubit.isSuaXoaDuyetBieuQuyet() &&
                widget.cubit.compareTime(widget.infoModel.thoiGianBatDau ?? ''))
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
                      onTap: () {
                        showDiaLog(
                          context,
                          showTablet: true,
                          textContent:
                              S.current.ban_co_chac_chan_muon_xoa_khong,
                          btnLeftTxt: S.current.khong,
                          funcBtnRight: () async {
                            await widget.cubit.xoaBieuQuyet(
                              bieuQuyetId: widget.infoModel.id ?? '',
                              canboId: '',
                            );
                          },
                          title: S.current.xoa_bieu_quyet,
                          btnRightTxt: S.current.dong_y,
                          icon: Container(
                            width: 56,
                            height: 56,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: statusCalenderRed.withOpacity(0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                ImageAssets.ic_delete_do,
                              ),
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(ImageAssets.ic_delete_do),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
