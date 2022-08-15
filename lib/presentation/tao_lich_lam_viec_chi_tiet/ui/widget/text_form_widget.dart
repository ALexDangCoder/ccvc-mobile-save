import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class TextFormWidget extends StatefulWidget {
  final String image;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final List<TextInputFormatter> formatters;

  const TextFormWidget({
    Key? key,
    this.controller,
    required this.image,
    required this.hint,
    this.formatters = const [],
    this.validator,
    this.onChange,
  }) : super(key: key);

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(widget.image),
        SizedBox(
          width: 14.0.textScale(),
        ),
        Expanded(
          child: TextFieldValidator(
            validator: widget.validator,
            controller: widget.controller,
            inputFormatters: widget.formatters,
            decoration: InputDecoration(
              labelStyle: textNormalCustom(
                color: titleItemEdit,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              hintStyle: textNormalCustom(
                color: colorA2AEBD,
                fontWeight: FontWeight.w400,
                fontSize: 16.0.textScale(),
              ),
              hintText: widget.hint,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: colorECEEF7),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: colorECEEF7),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: colorFF4F50),
              ),
              errorStyle: textNormalCustom(
                color: colorFF4F50,
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
