import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemLapDenNgayWidget extends StatefulWidget {
  final CreateWorkCalCubit createCubit;
  final bool createWorkCalendar;
  final DateTime? initDate;

  const ItemLapDenNgayWidget({
    Key? key,
    required this.createCubit,
    required this.createWorkCalendar,
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
    widget.createCubit.dateTimeLapDenNgay = widget.initDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(covariant ItemLapDenNgayWidget oldWidget) {
    widget.createCubit.dateTimeLapDenNgay = widget.initDate ?? DateTime.now();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandGroup(
      child: ExpandOnlyWidget(
        paddingTop: 5,
        header: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.lap_den_ngay,
                style: textNormal(color3D5586, 16.0),
              ),
              StreamBuilder<DateTime>(
                stream: widget.createCubit.changeDateTimeSubject.stream,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Text(
                          widget.createCubit.dateTimeLapDenNgay
                              .toStringWithListFormat,
                          style: textNormal(color3D5586, 16.0),
                        ),
                        spaceW10,
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        child: SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              maximumDate: DateTime(2099, 12, 30),
              maximumYear: 2099,
              minimumYear: DateTime.now().year,
              minimumDate: widget.createWorkCalendar
                  ? widget.initDate
                  : DateTime.parse(
                      widget.createCubit.dateTimeFrom ??
                          DateTime.now().toString(),
                    ),
              backgroundColor: backgroundColorApp,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              initialDateTime: widget.createWorkCalendar
                  ? widget.initDate
                  : widget.createCubit.dateTimeLapDenNgay,
              onDateTimeChanged: (value) {
                deboucer.run(() {
                  widget.createCubit.dateTimeLapDenNgay = value;
                  widget.createCubit.changeDateTimeSubject.add(value);
                });
              },
            )),
      ),
    );
  }
}
