import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';

class ItemTextFieldWidget extends StatelessWidget {
  final String title;
  final String hint;
  final bool isRequired;
  final int maxLine;
  final TextEditingController controller;
  final Function(String value) onChange;
  final String? Function(String? value) validator;

  const ItemTextFieldWidget({
    Key? key,
    required this.title,
    required this.hint,
    this.isRequired = false,
    required this.controller,
    required this.onChange,
    required this.validator,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: textNormalCustom(
                color: color586B8B,
                fontWeight: FontWeight.w400,
                fontSize: 14.0.textScale(),
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: textNormalCustom(
                  color: Colors.red,
                ),
              )
            else
              Container(),
          ],
        ),
        SizedBox(
          height: 8.0.textScale(),
        ),
        TextFieldValidator(
          controller: controller,
          hintText: hint,
          maxLine: maxLine,
          onChange: (value) {
            onChange(value);
          },
          validator: (value) {
            return validator(value);
          },
        )
      ],
    );
  }
}
