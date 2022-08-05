import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final focusNode = FocusNode();
  late TextSelectionControls _selectionControls;
  FormProvider? formProvider;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
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
      _selectionControls = AppMaterialTextSelectionControls(
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

class AppCupertinoTextSelectionControls extends CupertinoTextSelectionControls {
  AppCupertinoTextSelectionControls({
    required this.validatorPaste,
  });

  final bool Function(String) validatorPaste;

  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (validatorPaste(data?.text ?? '')) {
      await handlePasteValidator(delegate, data?.text);
    } else {
      delegate.bringIntoView(delegate.textEditingValue.selection.extent);
      delegate.hideToolbar();
    }
  }

  Future<void> handlePasteValidator(
      TextSelectionDelegate delegate, String? text) async {
    final TextEditingValue value =
        delegate.textEditingValue; // Snapshot the input before using `await`.
    if (text != null) {
      delegate.userUpdateTextEditingValue(
        TextEditingValue(
          text: value.selection.textBefore(value.text) +
              text +
              value.selection.textAfter(value.text),
          selection: TextSelection.collapsed(
            offset: value.selection.start + text.length,
          ),
        ),
        SelectionChangedCause.toolbar,
      );
    }
    delegate.bringIntoView(delegate.textEditingValue.selection.extent);
    delegate.hideToolbar();
  }
}

class AppMaterialTextSelectionControls extends MaterialTextSelectionControls {
  AppMaterialTextSelectionControls({
    required this.validatorPaste,
  });

  final bool Function(String)? validatorPaste;

  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    final validator = validatorPaste!(data?.text ?? '');

    if (validator) {
      await handlePasteValidator(delegate, data?.text);
    } else {
      delegate.bringIntoView(delegate.textEditingValue.selection.extent);
      delegate.hideToolbar();
    }
  }

  Future<void> handlePasteValidator(
      TextSelectionDelegate delegate, String? text) async {
    final TextEditingValue value =
        delegate.textEditingValue; // Snapshot the input before using `await`.
    if (text != null) {
      delegate.userUpdateTextEditingValue(
        TextEditingValue(
          text: value.selection.textBefore(value.text) +
              text +
              value.selection.textAfter(value.text),
          selection: TextSelection.collapsed(
            offset: value.selection.start + text.length,
          ),
        ),
        SelectionChangedCause.toolbar,
      );
    }
    delegate.bringIntoView(delegate.textEditingValue.selection.extent);
    delegate.hideToolbar();
  }
}
