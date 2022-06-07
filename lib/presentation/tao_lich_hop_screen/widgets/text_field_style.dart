import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldStyle extends StatelessWidget {
  final String? hintText;
  final String urlIcon;
  final int maxLines;
  final Function(String)? onChange;
  final Function(String)? validate;
  final TextEditingController? controller;
  final int? maxLength;

  const TextFieldStyle({
    Key? key,
    this.hintText,
    required this.urlIcon,
    this.maxLines = 1,
    this.onChange,
    this.controller,
    this.maxLength,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          width: 16.0.textScale(space: 4),
          height: 16.0.textScale(space: 4),
          color: Colors.transparent,
          child: SvgPicture.asset(urlIcon),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: maxLines == 1 ? 9 : 0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorECEEF7),
              ),
            ),
            child: textField(
              validate: validate,
            ),
          ),
        ),
      ],
    );
  }

  Widget textField({Function(String)? validate}) {
    return TextFormField(
      validator: (value) {
        return validate?.call(value ?? '');
      },
      controller: controller,
      onChanged: (value) {
        onChange?.call(value);
      },
      maxLength: maxLength,
      maxLines: maxLines,
      style: textNormal(color3D5586, 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textNormal(textBodyTime, 16),
        border: InputBorder.none,
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
