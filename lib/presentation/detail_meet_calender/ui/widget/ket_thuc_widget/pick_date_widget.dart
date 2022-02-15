import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/bloc/pick_date_cupertino_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickDateWidget extends StatefulWidget {
  final String title;
  final bool isNote;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final Color background;
  final Function(DateTime value) onChange;

  const PickDateWidget({
    Key? key,
    required this.title,
    this.isNote = false,
    this.maximumDate,
    this.minimumDate,
    this.background = bgrCalendar,
    required this.onChange,
  }) : super(key: key);

  @override
  State<PickDateWidget> createState() => _PickDateWidgetState();
}

class _PickDateWidgetState extends State<PickDateWidget> {
  final PicKDateCupertinoCubit picKDateCupertinoCubit =
      PicKDateCupertinoCubit();

  @override
  Widget build(BuildContext context) {
    return StartEndDateInherited(
      picKDateCupertinoCubit: picKDateCupertinoCubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: textNormalCustom(
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.textScale(),
                ),
              ),
              Text(
                ' *',
                style: textNormalCustom(
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0.textScale(),
          ),
          ExpandOnlyWidget(
            header: header(),
            isShowIcon: false,
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                maximumDate: widget.maximumDate,
                minimumDate: widget.minimumDate,
                backgroundColor: widget.background,
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime value) {
                  picKDateCupertinoCubit.listeningTaoLichHop(value);
                  widget.onChange(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.textScale(),
        vertical: 12.0.textScale(),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cellColorborder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<DateTime>(
              stream: picKDateCupertinoCubit.taoLichHopStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? DateTime.now();
                return Text(
                  data.toStringWithListFormat,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }),
          SvgPicture.asset(ImageAssets.icCalendar)
        ],
      ),
    );
  }
}