import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CusCheckBox extends StatefulWidget {
  const CusCheckBox({
    Key? key,
    this.isChecked = false,
    required this.onChange,
    this.enable = true,
    this.title = '',
  }) : super(key: key);
  final bool isChecked;
  final Function(bool) onChange;
  final bool enable;
  final String title;

  @override
  State<CusCheckBox> createState() => _CusCheckBoxState();
}

class _CusCheckBoxState extends State<CusCheckBox> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant CusCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        spaceW4,
        SizedBox(
          height: 16,
          width: 16,
          child: Checkbox(
            value: value,
            onChanged: (val) {
              if (!widget.enable) {
                return;
              }
              setState(() {
                value = !value;
              });
              widget.onChange(value);
            },
            activeColor: AppTheme.getInstance().colorField(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: value
                ? null
                : MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      width: 1.5,
                      color: colorECEEF7,
                    ),
                  ),
          ),
        ),
        if (widget.title.isNotEmpty) spaceW8 else const SizedBox.shrink(),
        if (widget.title.isNotEmpty)
          GestureDetector(
            onTap: () {
              if (!widget.enable) {
                return;
              }
              setState(() {
                value = !value;
              });
              widget.onChange(value);
            },
            child: Text(widget.title),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
