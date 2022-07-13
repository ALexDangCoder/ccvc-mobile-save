import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final Function(String?) onSelectDate;
  final String? hintText;
  final Widget? leadingIcon;
  final double? paddings;
  final DateTime? initDateTime;

  const DateInput({
    Key? key,
    required this.onSelectDate,
    this.initDateTime,
    this.hintText,
    this.leadingIcon,
    this.paddings,
  }) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  String? dateSelect;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFieldValidator(
      controller: textController,
      hintText: DateFormatApp.date,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return null;
        }
        try {
          final inputDate = DateFormat(DateFormatApp.date).parse(value ?? '');
          dateSelect = inputDate.toString();
          widget.onSelectDate(dateSelect);
        } catch (_) {
          return S.current.nhap_sai_dinh_dang;
        }
      },
      suffixIcon: GestureDetector(
        onTap: () {
          DateTime initDate = DateTime.now();
          if(textController.text != '') {
             initDate = DateFormat(DateFormatApp.date).parse(
              textController.text,
            );
          }
          final dateSince = initDate.millisecondsSinceEpoch;
          if (dateSince < DateTime(1900).millisecondsSinceEpoch ||
              dateSince > DateTime.now().millisecondsSinceEpoch) {
            initDate = DateTime(2000);
          }
          showBottomSheetCustom(
            context,
            title: S.current.chon_ngay,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: FlutterRoundedCupertinoDatePickerWidget(
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (value) {
                      setState(() {
                        dateSelect = value.toString();
                      });
                    },
                    textStyleDate: titleAppbar(),
                    initialDateTime: initDate,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 32,
                  ),
                  child: DoubleButtonBottom(
                    title2: S.current.chon,
                    title1: S.current.dong,
                    onClickRight: () {
                      textController.text = DateTime.parse(dateSelect ?? '')
                          .toStringWithListFormat;
                      widget.onSelectDate(dateSelect);
                      Navigator.pop(context);
                    },
                    onClickLeft: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: widget.leadingIcon ?? const SizedBox(),
        ),
      ),
    );
  }
}
