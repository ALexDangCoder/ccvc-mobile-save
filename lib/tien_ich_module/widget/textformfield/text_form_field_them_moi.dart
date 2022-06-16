import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/form_group/form_group.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldStyle extends StatefulWidget {
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
  final String urlIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool Function(String)? validatorPaste;
  final int? maxLenght;

  const TextFieldStyle({
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
    this.inputFormatters,
    required this.urlIcon,
    this.validatorPaste,
    this.maxLenght,
  }) : super(key: key);

  @override
  State<TextFieldStyle> createState() => _TextFieldStyleState();
}

class _TextFieldStyleState extends State<TextFieldStyle> {
  final key = GlobalKey<FormState>();
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
    return Row(
      crossAxisAlignment: widget.maxLine == 1
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
                EdgeInsets.symmetric(vertical: widget.maxLine == 1 ? 2 : 0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorECEEF7),
              ),
            ),
            child: textFromField(),
          ),
        ),
      ],
    );
  }

  Widget textFromField() {
    return Form(
      key: key,
      child: TextFormField(
        maxLength: widget.maxLenght,
        selectionControls: _selectionControls,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        onChanged: (value) {
          if (formProvider != null) {
            formProvider?.validator[key] = key.currentState!.validate();
          }
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        initialValue: widget.initialValue,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLine,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        style: textNormal(color3D5586, 14),
        enabled: widget.isEnabled,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          hintStyle: textNormal(textBodyTime, 14),
          contentPadding: EdgeInsets.zero,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          fillColor: widget.isEnabled
              ? widget.fillColor ?? Colors.transparent
              : borderColor.withOpacity(0.3),
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
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
        SelectionChangedCause.toolBar,
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
        SelectionChangedCause.toolBar,
      );
    }
    delegate.bringIntoView(delegate.textEditingValue.selection.extent);
    delegate.hideToolbar();
  }
}
