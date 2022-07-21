import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemLapDenNgayWidget extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final bool isThem;
  final DateTime? initDate;

  const ItemLapDenNgayWidget({
    Key? key,
    required this.taoLichLamViecCubit,
    required this.isThem,
    this.initDate,
  }) : super(key: key);

  @override
  _ItemLapDenNgayWidgetState createState() => _ItemLapDenNgayWidgetState();
}

class _ItemLapDenNgayWidgetState extends State<ItemLapDenNgayWidget> {
  late AnimationController? expandController;
  bool isShowDatePicker = false;
  final Debouncer deboucer = Debouncer();

  @override
  void initState() {
    super.initState();
    widget.taoLichLamViecCubit.dateTimeLapDenNgay =
        widget.initDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant ItemLapDenNgayWidget oldWidget) {
    widget.taoLichLamViecCubit.dateTimeLapDenNgay =
        widget.initDate ?? DateTime.now();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isThem
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.lap_den_ngay,
                      style: textNormal(color3D5586, 16.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        isShowDatePicker = !isShowDatePicker;
                        setState(() {});
                      },
                      child: StreamBuilder<DateTime>(
                        stream: widget
                            .taoLichLamViecCubit.changeDateTimeSubject.stream,
                        builder: (context, snapshot) {
                          return Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  widget.taoLichLamViecCubit.dateTimeLapDenNgay
                                      .toStringWithListFormat,
                                  style: textNormal(color3D5586, 16.0),
                                ),
                                spaceW10,
                                RotatedBox(
                                  quarterTurns: isShowDatePicker ? 2 : 0,
                                  child: SvgPicture.asset(
                                    ImageAssets.icDropDown,
                                    color: colorA2AEBD,
                                  ),
                                ),
                                spaceW6,
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                spaceH10,
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  height: isShowDatePicker ? 300 : 1,
                  child: isShowDatePicker
                      ? FlutterRoundedCupertinoDatePickerWidget(
                          minimumDate: DateTime.now(),
                          textStyleDate: textNormal(color3D5586, 16),
                          initialDateTime: widget.initDate,
                          onDateTimeChanged: (value) {
                            deboucer.run(() {
                              widget.taoLichLamViecCubit.dateTimeLapDenNgay =
                                  value;
                              widget.taoLichLamViecCubit.changeDateTimeSubject
                                  .add(value);
                              //setState(() {});
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                Visibility(
                  visible: !isShowDatePicker,
                  child: Container(
                    margin: const EdgeInsets.only(top: 11),
                    height: 1,
                    color: colorA2AEBD.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.lap_den_ngay,
                      style: textNormal(color3D5586, 16.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        isShowDatePicker = !isShowDatePicker;
                        setState(() {});
                      },
                      child: StreamBuilder<DateTime>(
                        stream: widget
                            .taoLichLamViecCubit.changeDateTimeSubject.stream,
                        builder: (context, snapshot) {
                          return Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  widget.taoLichLamViecCubit.dateTimeLapDenNgay
                                      .toStringWithListFormat,
                                  style: textNormal(color3D5586, 16.0),
                                ),
                                spaceW10,
                                RotatedBox(
                                  quarterTurns: isShowDatePicker ? 2 : 0,
                                  child: SvgPicture.asset(
                                    ImageAssets.icDropDown,
                                    color: colorA2AEBD,
                                  ),
                                ),
                                spaceW6,
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  height: isShowDatePicker ? 200 : 1,
                  child: isShowDatePicker
                      ? FlutterRoundedCupertinoDatePickerWidget(
                          textStyleDate: textNormal(color3D5586, 16),
                          minimumDate:
                              widget.taoLichLamViecCubit.dateTimeLapDenNgay,
                          initialDateTime:
                              widget.taoLichLamViecCubit.dateTimeLapDenNgay,
                          onDateTimeChanged: (value) {
                            deboucer.run(() {
                              widget.taoLichLamViecCubit.dateTimeLapDenNgay =
                                  value;
                              widget.taoLichLamViecCubit.changeDateTimeSubject
                                  .add(value);
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                Visibility(
                  visible: !isShowDatePicker,
                  child: Container(
                    margin: const EdgeInsets.only(top: 11),
                    height: 1,
                    color: colorA2AEBD.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          );
  }
}
