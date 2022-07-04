import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockTextViewLich extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController contentController;
  final String title;
  final bool isRequired;
  final String? hintText;
  final bool isLimitCharacter;
  final String? Function(String?)? validator;
  final bool isHideRequired;
  final bool useCustomTitle;
  final int? maxLenght;

  const BlockTextViewLich({
    Key? key,
    required this.formKey,
    required this.contentController,
    required this.title,
    this.hintText,
    this.validator,
    this.isHideRequired = false,
    this.isRequired = true,
    this.isLimitCharacter = false,
    this.useCustomTitle = false,
    this.maxLenght,
  }) : super(key: key);

  @override
  _BlockTextViewLichState createState() => _BlockTextViewLichState();
}

class _BlockTextViewLichState extends State<BlockTextViewLich> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: borderCaneder,
              ),
            ),
            if (widget.isRequired)
              Text(
                ' *',
                style: tokenDetailAmount(
                  fontSize: 14.0.textScale(),
                  color: Colors.red,
                ),
              )
            else
              const SizedBox()
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Form(
          key: widget.formKey,
          child: TextFormField(
            maxLength: widget.maxLenght,
            controller: widget.contentController,
            maxLines: 4,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: tokenDetailAmount(
              fontSize: 14.0.textScale(),
              color: color3D5586,
            ),
            decoration: InputDecoration(
              counterText: '',
              hintStyle: tokenDetailAmount(
                fontSize: 14.0.textScale(),
                color: titleItemEdit.withOpacity(0.5),
              ),
              hintText: widget.hintText,
              fillColor: backgroundColorApp,
              filled: true,
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: canceledColor,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: canceledColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              errorStyle: tokenDetailAmount(fontSize: 12, color: canceledColor),
            ),
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(value);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
