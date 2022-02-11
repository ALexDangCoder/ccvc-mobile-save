import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomSelectHour extends StatefulWidget {
  final String? value;
  final Function(DateTime) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;

  const CustomSelectHour({
    Key? key,
    this.value,
    required this.onSelectDate,
    this.hintText,
    this.backgroundColor,
    this.leadingIcon,
    this.isObligatory = false,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomSelectHour> {
  String dateSelect = '';

  @override
  void didUpdateWidget(covariant CustomSelectHour oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    dateSelect = widget.value ?? DateTime.now().toString();
  }

  @override
  void initState() {
    if (!widget.isObligatory) {
      dateSelect = widget.value ?? DateTime.now().hour.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              TextFieldValidator(
                textInputType: TextInputType.number,
              )
            ],
          ),
          Positioned(
            right: 14,
            height: 44,
            child: Center(
              child: widget.leadingIcon ?? const SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
