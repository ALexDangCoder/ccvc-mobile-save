import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';

class RadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T?) onChange;
  final String title;
  final bool useBlueColor;

  const RadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChange,
    this.title = '',
    this.useBlueColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(value);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Radio<T>(
                fillColor: MaterialStateColor.resolveWith((states) {
                  if (states.isEmpty) {
                    return useBlueColor
                        ? AppTheme.getInstance().colorSelect().withOpacity(0.8)
                        : radioUnfocusColor;
                  }
                  return AppTheme.getInstance().colorSelect();
                }),
                value: value,
                groupValue: groupValue,
                onChanged: (value) {
                  onChange(value);
                },
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            Text(
              title,
              style: textNormal(
                textTitle,
                14.0.textScale(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
