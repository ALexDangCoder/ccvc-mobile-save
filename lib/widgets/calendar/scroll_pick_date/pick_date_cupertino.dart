import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/title_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';

class PicKDateCupertino extends StatefulWidget {
  final String title;
  final Function(DateTime value) onDateTimeChanged;
  final String dateAndTime;
  final Color background;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final CupertinoDatePickerMode mode;
  const PicKDateCupertino({
    Key? key,
    required this.title,
    required this.dateAndTime,
    this.maximumDate,
    this.minimumDate,
    this.background = bgBottomTab,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  _PicKDateCupertinoState createState() => _PicKDateCupertinoState();
}

class _PicKDateCupertinoState extends State<PicKDateCupertino> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          isLine: true,
          isColor: true,
          title2: widget.dateAndTime,
          title: widget.title,
          child: Container(
            margin: EdgeInsets.only(left: 32.5.textScale()),
            height: 311.0.textScale(),
            child: CupertinoDatePicker(
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              backgroundColor: widget.background,
              mode: widget.mode,
              use24hFormat: true,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime value) {
                widget.onDateTimeChanged(value);
              },
            ),
          ),
        )
      ],
    );
  }
}
