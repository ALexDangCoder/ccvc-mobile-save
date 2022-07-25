import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/bloc/date_time_cupertino_custom_cubit.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CupertinoTimePickerCustom extends StatefulWidget {
  const CupertinoTimePickerCustom({
    Key? key,
    this.isAddMargin = false,
    this.isSwitchButtonChecked = false,
    this.onSwitchPressed,
    this.initTimeStart,
    this.initTimeEnd,
    this.initDateStart,
    this.initDateEnd,
    required this.onDateTimeChanged,
  }) : super(key: key);

  final bool isAddMargin;
  final bool isSwitchButtonChecked;
  final Function(bool)? onSwitchPressed;
  final DateTime? initTimeStart;
  final DateTime? initTimeEnd;
  final DateTime? initDateStart;
  final DateTime? initDateEnd;
  final Function(
      String timeStart,
      String timeEnd,
      String dateStart,
      String dateEnd,
      ) onDateTimeChanged;

  @override
  _CupertinoTimePickerCustomState createState() =>
      _CupertinoTimePickerCustomState();
}

class _CupertinoTimePickerCustomState extends State<CupertinoTimePickerCustom> {
  late final DateTimeCupertinoCustomCubit cubit;
  late final Debouncer debouncer;

  @override
  void initState() {
    super.initState();
    cubit = DateTimeCupertinoCustomCubit();
    debouncer = Debouncer();
    cubit.onTimeChanged(
      timeSelected: widget.initTimeEnd ?? DateTime.now(),
      typePicker: TypePickerDateTime.TIME_END,
    );
    cubit.onTimeChanged(
      timeSelected: widget.initDateEnd ?? DateTime.now(),
      typePicker: TypePickerDateTime.DATE_END,
    );
    cubit.onTimeChanged(
      timeSelected: widget.initTimeStart ?? DateTime.now(),
      typePicker: TypePickerDateTime.TIME_START,
    );
    cubit.onTimeChanged(
      timeSelected: widget.initDateStart ?? DateTime.now(),
      typePicker: TypePickerDateTime.DATE_START,
    );
    cubit.isSwitchBtnCheckedSubject.add(widget.isSwitchButtonChecked);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Switch Button
        Row(
          children: [
            SizedBox(
              height: 18.0.textScale(),
              width: 18.0.textScale(),
              child: SvgPicture.asset(ImageAssets.icNhacLai),
            ),
            SizedBox(
              width: 14.5.textScale(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical:
                  widget.isAddMargin ? 16.0.textScale() : 14.0.textScale(),
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colorECEEF7,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.ca_ngay,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16.0.textScale(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    StreamBuilder<bool>(
                      initialData: widget.isSwitchButtonChecked,
                      stream: cubit.isSwitchBtnCheckedSubject,
                      builder: (context, snapshot) {
                        final bool isChecked = snapshot.data ?? false;
                        return CustomSwitch(
                          value: isChecked,
                          onToggle: (bool value) {
                            cubit.handleSwitchButtonPressed(isToggled: value);
                            widget.onSwitchPressed?.call(value);
                            widget.onDateTimeChanged(
                              cubit.timeBeginSubject.value,
                              cubit.timeEndSubject.value,
                              cubit.dateBeginSubject.value,
                              cubit.dateEndSubject.value,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        spaceH24,

        ///bắt đầu
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.bat_dau,
                style: textNormal(titleItemEdit, 16),
              ),
              StreamBuilder<bool>(
                stream: cubit.isSwitchBtnCheckedSubject,
                builder: (context, snapshot) {
                  final bool isShowTime = snapshot.data ?? false;
                  return Visibility(
                    visible: !isShowTime,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.setTypePickerStart(TypePickerDateTime.TIME_START);
                        //cubit.handleDateTimePressed();
                        cubit.lastedType = TypePickerDateTime.TIME_START;
                      },
                      child: StreamBuilder<String>(
                        stream: cubit.timeBeginSubject,
                        builder: (context, snapshot) {
                          final String time = snapshot.data ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              time,
                              style: textNormal(titleItemEdit, 16),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder<String>(
                stream: cubit.dateBeginSubject,
                builder: (context, snapshot) {
                  final String date = snapshot.data ?? S.current.ddmmyy;
                  return GestureDetector(
                    onTap: () {
                      cubit.setTypePickerStart(TypePickerDateTime.DATE_START);
                      //cubit.handleDateTimePressed();
                      cubit.lastedType = TypePickerDateTime.DATE_START;
                    },
                    child: Text(
                      date,
                      style: textNormal(titleItemEdit, 16),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        StreamBuilder<bool>(
          stream: cubit.isShowBeginPickerSubject,
          builder: (context, snapshot) {
            final bool isShowPicker = snapshot.data ?? false;
            return StreamBuilder<TypePickerDateTime>(
              stream: cubit.typePickerSubjectStart,
              builder: (context, typeSnapshot) {
                final typePicker =
                    typeSnapshot.data ?? TypePickerDateTime.TIME_START;
                return AnimatedContainer(
                  height: isShowPicker ? 200 : 1,
                  width: MediaQuery.of(context).size.width,
                  duration: Duration(milliseconds: cubit.duration),
                  child: isShowPicker
                      ? CupertinoDatePicker(
                    maximumDate: MAXIMUM_DATE,
                    minimumDate:MINIMUM_DATE,
                    maximumYear: MAXIMUM_YEAR,
                    minimumYear: MINIMUM_YEAR,
                    backgroundColor: backgroundColorApp,
                    mode: cubit.getTypePicker(typePicker),
                    use24hFormat: true,
                    initialDateTime: '${cubit.dateBeginSubject.value} '
                        '${cubit.timeBeginSubject.value}'
                        .convertStringToDate(
                      formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                    ),
                    onDateTimeChanged: (value) {
                      debouncer.run(
                            () {
                          cubit.onTimeChanged(
                            timeSelected: value,
                            typePicker: typePicker,
                          );
                          widget.onDateTimeChanged(
                            cubit.timeBeginSubject.value,
                            cubit.timeEndSubject.value,
                            cubit.dateBeginSubject.value,
                            cubit.dateEndSubject.value,
                          );
                        },
                      );
                    },
                  )
                      : const SizedBox(
                    height: 1,
                  ),
                );
              },
            );
          },
        ),

        ///kết thúc
        spaceH24,
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.ket_thuc,
                style: textNormal(titleItemEdit, 16),
              ),
              StreamBuilder<bool>(
                stream: cubit.isSwitchBtnCheckedSubject,
                builder: (context, snapshot) {
                  final bool isShowTime = snapshot.data ?? false;
                  return Visibility(
                    visible: !isShowTime,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.setTypePickerStart(TypePickerDateTime.TIME_END);
                        //cubit.handleDateTimePressed(isBegin: false);
                        cubit.lastedType = TypePickerDateTime.TIME_END;
                      },
                      child: StreamBuilder<String>(
                        stream: cubit.timeEndSubject,
                        builder: (context, snapshot) {
                          final String time = snapshot.data ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              time,
                              style: textNormal(titleItemEdit, 16),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder<String>(
                stream: cubit.dateEndSubject,
                builder: (context, snapshot) {
                  final String date = snapshot.data ?? S.current.ddmmyy;
                  return GestureDetector(
                    onTap: () {
                      cubit.setTypePickerStart(TypePickerDateTime.DATE_END);
                      //cubit.handleDateTimePressed(isBegin: false);
                      cubit.lastedType = TypePickerDateTime.DATE_END;
                    },
                    child: Text(
                      date,
                      style: textNormal(titleItemEdit, 16),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        StreamBuilder<bool>(
          stream: cubit.isShowEndPickerSubject,
          builder: (context, snapshot) {
            final bool isShowPicker = snapshot.data ?? false;
            return StreamBuilder<TypePickerDateTime>(
              stream: cubit.typePickerSubjectStart,
              builder: (context, typeSnapshot) {
                final typePicker =
                    typeSnapshot.data ?? TypePickerDateTime.TIME_END;
                return AnimatedContainer(
                  height: isShowPicker ? 200 : 1,
                  width: MediaQuery.of(context).size.width,
                  duration: Duration(milliseconds: cubit.duration),
                  child: isShowPicker
                      ? CupertinoDatePicker(
                    key: UniqueKey(),
                    maximumDate: MAXIMUM_DATE,
                    minimumDate: '${cubit.dateBeginSubject.value} '
                        '${cubit.timeBeginSubject.value}'
                        .convertStringToDate(
                      formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                    ),
                    maximumYear: MAXIMUM_YEAR,
                    minimumYear: cubit.getYearNumber(),
                    backgroundColor: backgroundColorApp,
                    mode: cubit.getTypePicker(typePicker),
                    use24hFormat: true,
                    initialDateTime: '${cubit.dateEndSubject.value} '
                        '${cubit.timeEndSubject.value}'
                        .convertStringToDate(
                      formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                    ),
                    onDateTimeChanged: (value) {
                      debouncer.run(
                            () {
                          cubit.onTimeChanged(
                            timeSelected: value,
                            typePicker: typePicker,
                          );
                          widget.onDateTimeChanged(
                            cubit.timeBeginSubject.value,
                            cubit.timeEndSubject.value,
                            cubit.dateBeginSubject.value,
                            cubit.dateEndSubject.value,
                          );
                        },
                      );
                    },
                  )
                      : const SizedBox(
                    height: 1,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
