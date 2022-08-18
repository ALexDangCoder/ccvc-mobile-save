import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldStyle extends StatefulWidget {
  final String? hintText;
  final String urlIcon;
  final int maxLines;
  final Function(String)? onChange;
  final Function(String)? validate;
  final TextEditingController? controller;
  final int? maxLength;
  final String? initValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;

  const TextFieldStyle({
    Key? key,
    this.hintText,
    required this.urlIcon,
    this.maxLines = 1,
    this.onChange,
    this.controller,
    this.maxLength,
    this.validate,
    this.initValue,
    this.inputFormatters,
    this.textInputType,
  }) : super(key: key);

  @override
  State<TextFieldStyle> createState() => _TextFieldStyleState();
}

class _TextFieldStyleState extends State<TextFieldStyle> {
  final key = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: widget.maxLines == 1
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Container(
          width: 16.0.textScale(space: 4),
          height: 16.0.textScale(space: 4),
          color: Colors.transparent,
          child: SvgPicture.asset(widget.urlIcon),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: widget.maxLines == 1 ? 9 : 0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorECEEF7),
              ),
            ),
            child: textField(
              validate: widget.validate,
              initValue: widget.initValue,
              textInputType: widget.textInputType,
              inputFormatters: widget.inputFormatters,
            ),
          ),
        ),
      ],
    );
  }

  Widget textField({
    Function(String)? validate,
    String? initValue,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? textInputType,
  }) {
    return TextFieldValidator(
      key: key,
      validator: (value) {
        return validate?.call((value ?? '').trim());
      },
      controller: widget.controller,
      onChange: (value) {
        widget.onChange?.call(value.trim());
        key.currentState?.validate();
      },
      initialValue: initValue,
      maxLength: widget.maxLength,
      maxLine: widget.maxLines,
      textInputType: textInputType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textNormal(textBodyTime, 16),
        border: InputBorder.none,
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.zero,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorFF4F50),
        ),
        errorStyle: textNormalCustom(
          color: colorFF4F50,
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
