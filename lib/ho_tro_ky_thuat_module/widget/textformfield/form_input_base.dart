import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/close_text_base.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/text_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormInputBase extends StatefulWidget {
  const FormInputBase({
    Key? key,
    required this.hintText,
    this.initText = '',
    this.validateFun,
    this.textInputType,
    this.isClose = false,
    this.maxLength,
    this.icon,
    required this.onChange,
  }) : super(key: key);
  final bool isClose;
  final String? icon;
  final String hintText;
  final String initText;
  final int? maxLength;
  final Function? validateFun;
  final Function(String) onChange;
  final TextInputType? textInputType;

  @override
  _FormInputBaseState createState() => _FormInputBaseState();
}

class _FormInputBaseState extends State<FormInputBase> {
  late TextEditingController textEditingController;
  String textValidate = '';

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.text = widget.initText;

    textEditingController.addListener(() {
      widget.onChange(
        textEditingController.value.text,
      );
      if (widget.validateFun != null) {
        textValidate = widget.validateFun!(
          textEditingController.text,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: colorNumberCellQLVB,
            borderRadius: BorderRadius.circular(
              6,
            ),
            border: Border.all(
              color: borderItemCalender,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: TextFormField(
              keyboardType: widget.textInputType,
              controller: textEditingController,
              maxLength: widget.maxLength ?? 999,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                counterText: '',
                hintText: widget.hintText,
                hintStyle: textNormal(
                  AppTheme.getInstance().unselectColor(),
                  14,
                ),
                border: InputBorder.none,
                prefixIcon: widget.icon?.isNotEmpty ?? false
                    ? Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: SvgPicture.asset(
                          widget.icon ?? '',
                          color: AppTheme.getInstance().colorField(),
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 14,
                  minWidth: 14,
                  maxHeight: 14,
                  maxWidth: 14,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 20,
                  minWidth: 28,
                  maxHeight: 20,
                  maxWidth: 28,
                ),
                suffixIcon: widget.isClose
                    ? CloseTextBase(
                        textEditingController: textEditingController,
                      )
                    : null,
              ),
            ),
          ),
        ),
        if (widget.validateFun != null) spaceH4,
        if (widget.validateFun != null)
          ValidateTextBase(
            textEditingController: textEditingController,
            textValidate: textValidate,
          ),
      ],
    );
  }
}
