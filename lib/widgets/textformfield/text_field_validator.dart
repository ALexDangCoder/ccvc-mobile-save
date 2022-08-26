import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'cupertino_text_selection_controls.dart';
import 'custom_ material_text_selection_controls.dart';

class TextFieldValidator extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool isEnabled;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? textInputType;
  final int maxLine;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Color? fillColor;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool Function(String)? validatorPaste;
  final InputDecoration? decoration;

  const TextFieldValidator({
    Key? key,
    this.controller,
    this.isEnabled = true,
    this.onChange,
    this.validator,
    this.initialValue,
    this.maxLine = 1,
    this.textInputType,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.obscureText,
    this.fillColor,
    this.maxLength,
    this.inputFormatters,
    this.validatorPaste,
    this.decoration,
  }) : super(key: key);

  @override
  State<TextFieldValidator> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFieldValidator> {
  final key = GlobalKey<FormState>();
  final keyTextFeild = GlobalKey();
  final focusNode = FocusNode();
  late TextSelectionControls _selectionControls;
  FormProvider? formProvider;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        if (_selectionControls is AppCupertinoTextSelectionControls) {
          (_selectionControls as AppCupertinoTextSelectionControls)
              .boxTextFeild = getOffsetTextFeild();
        }
      });
      _selectionControls = AppCupertinoTextSelectionControls(
        validatorPaste: (value) {
          if (widget.validatorPaste == null) {
            return true;
          } else {
            return widget.validatorPaste!(value);
          }
        },
      );
    } else {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        if (_selectionControls is CustomMaterialTextSelectionControls) {
          (_selectionControls as CustomMaterialTextSelectionControls)
              .boxTextFeild = getOffsetTextFeild();
        }
      });
      _selectionControls = CustomMaterialTextSelectionControls(
        validatorPaste: (value) {
          if (widget.validatorPaste == null) {
            return true;
          } else {
            return widget.validatorPaste!(value);
          }
        },
      );
    }

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      formProvider = FormProvider.of(context);
      if (formProvider != null) {
        if (widget.validator != null) {
          final validator =
              widget.validator!(widget.controller?.text ?? '') == null;
          formProvider?.validator.addAll({key: validator});
        } else {
          formProvider?.validator.addAll({key: true});
        }
        formProvider?.focusMap.addAll({key: focusNode});
      }
    });
    if (formProvider != null) {
      formProvider?.validator.addAll({key: true});
    }
  }

  RenderBox? getOffsetTextFeild() =>
      keyTextFeild.currentContext?.findRenderObject() as RenderBox?;

  @override
  void dispose() {
    super.dispose();
    formProvider?.validator.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: TextFormField(
        key: keyTextFeild,
        focusNode: focusNode,
        selectionControls: _selectionControls,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        onChanged: (value) {
          if (formProvider != null) {
            formProvider?.validator[key] = key.currentState!.validate();
          }
          widget.onChange?.call(value.removeSpace);
        },
        initialValue: widget.initialValue,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLine,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        style: tokenDetailAmount(
          fontSize: 14.0.textScale(),
          color: color3D5586,
        ),
        enabled: widget.isEnabled,
        decoration: widget.decoration ??
            InputDecoration(
              counterText: '',
              hintText: widget.hintText,
              hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
              contentPadding: widget.maxLine == 1
                  ? const EdgeInsets.symmetric(vertical: 14, horizontal: 10)
                  : null,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              fillColor: widget.isEnabled
                  ? widget.fillColor ?? Colors.transparent
                  : borderColor.withOpacity(0.3),
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
        },
      ),
    );
  }
}
