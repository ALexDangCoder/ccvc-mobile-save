import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldStyle extends StatefulWidget {
  final String? hintText;
  final String urlIcon;
  final int maxLines;
  String? initialText;
  final Function(String)? onChange;
  final Function(String)? validate;
  TextEditingController? controller;
  final int? maxLength;

  TextFieldStyle({
    Key? key,
    this.hintText,
    required this.urlIcon,
    this.maxLines = 1,
    this.onChange,
    this.controller,
    this.maxLength,
    this.validate, this.initialText,
  }) : super(key: key);

  @override
  State<TextFieldStyle> createState() => _TextFieldStyleState();
}

class _TextFieldStyleState extends State<TextFieldStyle> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialText ?? '');
    widget.controller = _controller;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          widget.maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
            padding: EdgeInsets.symmetric(vertical: widget.maxLines == 1 ? 9 : 0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorECEEF7),
              ),
            ),
            child: textField(
              validate: widget.validate,
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
      controller: widget.controller,
      onChanged: (value) {
        widget.onChange?.call(value);
      },
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      style: textNormal(color3D5586, 16),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textNormal(textBodyTime, 16),
        border: InputBorder.none,
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
