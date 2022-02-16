import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class FormDisplayText extends StatefulWidget {
  final String text;

  const FormDisplayText(this.text, {Key? key}) : super(key: key);

  @override
  _FormDisplayTextState createState() => _FormDisplayTextState();
}

class _FormDisplayTextState extends State<FormDisplayText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        widget.text,
        style: textNormal(textDropDownColor, 14.0.textScale()),
      ),
    );
  }
}
