import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockTextView extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController contentController;
  final String title;
  final bool isRequired;
  final String? hintText;
  final bool isLimitCharacter;
  final bool? validate;
  final bool isHideRequired;
  final bool useCustomTitle;
  final int maxLines;
  final String? textValidate;

  const BlockTextView({
    Key? key,
    required this.formKey,
    required this.contentController,
    required this.title,
    this.hintText,
    this.validate,
    this.isHideRequired = false,
    this.isRequired = true,
    this.isLimitCharacter = false,
    this.useCustomTitle = false,
    this.textValidate = '',
    this.maxLines = 5,
  }) : super(key: key);

  @override
  _BlockTextViewState createState() => _BlockTextViewState();
}

class _BlockTextViewState extends State<BlockTextView> {
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
            controller: widget.contentController,
            maxLines: widget.maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: tokenDetailAmount(
              fontSize: 14.0.textScale(),
              color: color3D5586,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: textNormal(textBodyTime, 14),
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
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              errorStyle: tokenDetailAmount(fontSize: 12, color: canceledColor),
            ),
            validator: (String? value) {
              if (widget.validate ?? true) {
                if (value == null ||
                    value.trim().isEmpty && widget.isRequired) {
                  if (widget.textValidate!.isNotEmpty) {
                    return widget.textValidate;
                  }
                  return S.current.khong_duoc_de_trong;
                }
                // if (widget.isLimitCharacter && value.length > 255) {
                //   return 'limit_character';
                // }
              }

              return null;
            },
          ),
        ),
      ],
    );
  }
}
