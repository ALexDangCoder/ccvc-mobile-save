import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/is_ca_ngay_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/bloc/pick_date_cupertino_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/pick_date_cupertino.dart';
import 'package:flutter/cupertino.dart';

class StartEndDateWidget extends StatefulWidget {
  final Function(DateTime value) onStartDateTimeChanged;
  final Function(DateTime value) onEndDateTimeChanged;
  final bool icMargin;

  const StartEndDateWidget({
    Key? key,
    required this.onStartDateTimeChanged,
    required this.onEndDateTimeChanged,
    this.icMargin = true,
  }) : super(key: key);

  @override
  _StartEndDateWidgetState createState() => _StartEndDateWidgetState();
}

class _StartEndDateWidgetState extends State<StartEndDateWidget> {
  final PicKDateCupertinoCubit picKDateCupertinoCubit =
      PicKDateCupertinoCubit();

  @override
  Widget build(BuildContext context) {
    return StartEndDateInherited(
      picKDateCupertinoCubit: picKDateCupertinoCubit,
      child: StreamBuilder<bool>(
        stream: picKDateCupertinoCubit.isDateTimeStream,
        builder: (context, snapshot) {
          final dataBool = snapshot.data ?? true;
          return Column(
            children: [
              IsCaNgayWidget(
                isMargin: widget.icMargin,
              ),
              SizedBox(
                height: 16.0.textScale(),
              ),
              PicKDateCupertino(
                key: UniqueKey(),
                isUnderLine: true,
                minimumDate: DateTime.now(),
                mode: dataBool
                    ? CupertinoDatePickerMode.date
                    : CupertinoDatePickerMode.dateAndTime,
                onDateTimeChanged: (DateTime value) {
                  picKDateCupertinoCubit.listeningStartDataTime(
                    value,
                  );

                  widget.onStartDateTimeChanged(value);
                },
                title: S.current.bat_dau,
                startOfEnd: StartOfEnd.START,
              ),
              SizedBox(
                height: 16.0.textScale(),
              ),
              StreamBuilder<DateTime>(
                  stream: StartEndDateInherited.of(context)
                      .picKDateCupertinoCubit
                      .startDateStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? DateTime.now();
                  return PicKDateCupertino(
                      key: UniqueKey(),
                      isUnderLine: true,
                      minimumDate: data,
                      maximumDate:
                          DateTime(data.year + 5, data.month, data.day),
                      mode: dataBool
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.dateAndTime,
                      onDateTimeChanged: (DateTime value) {
                        picKDateCupertinoCubit.listeningEndDataTime(
                          value,
                        );
                        widget.onEndDateTimeChanged(value);
                      },
                      title: S.current.ket_thuc,
                      startOfEnd: StartOfEnd.END,
                    );
                  },)
            ],
          );
        },
      ),
    );
  }
}

class StartEndDateInherited extends InheritedWidget {
  final PicKDateCupertinoCubit picKDateCupertinoCubit;

  const StartEndDateInherited({
    Key? key,
    required this.picKDateCupertinoCubit,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static StartEndDateInherited of(BuildContext context) {
    final StartEndDateInherited? result =
        context.dependOnInheritedWidgetOfExactType<StartEndDateInherited>();
    assert(result != null, 'No elenment');
    return result!;
  }
}
