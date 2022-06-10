import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class ItemCustomGroupRadio<T> {
  String title;
  T value;

  ItemCustomGroupRadio({
    required this.title,
    required this.value,
  });
}

class CustomGroupRadio<T> extends StatefulWidget {
  final Function(T?) onchange;
  final List<ItemCustomGroupRadio<T>> listData;
  T groupValue;

  CustomGroupRadio({
    Key? key,
    required this.onchange,
    required this.groupValue,
    required this.listData,
  }) : super(key: key);

  @override
  _CustomGroupRadioState<T> createState() => _CustomGroupRadioState();
}

class _CustomGroupRadioState<T> extends State<CustomGroupRadio<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.listData
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Radio<T>(
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      activeColor: textDefault,
                      value: e.value,
                      onChanged: (T? value) {
                        setState(() {
                          widget.groupValue = e.value;
                        });
                        widget.onchange(value);
                      },
                      groupValue: widget.groupValue,
                    ),
                  ),
                  spaceW16,
                  Text(
                    e.title,
                    style: tokenDetailAmount(
                      fontSize: 14,
                      color: color3D5586,
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Color getColor(Set<MaterialState> states) {
    return textDefault;
  }
}
