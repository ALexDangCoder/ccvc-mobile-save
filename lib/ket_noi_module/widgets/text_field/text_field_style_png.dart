import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/material.dart';

class TextFieldStylePNG extends StatefulWidget {
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

  const TextFieldStylePNG({
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
    required this.urlIcon,
  }) : super(key: key);

  @override
  State<TextFieldStylePNG> createState() => _TextFieldStylePNGState();
}

class _TextFieldStylePNGState extends State<TextFieldStylePNG> {
  final key = GlobalKey<FormState>();
  FormProvider? formProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    formProvider = FormProvider.of(context);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
          child: Image.asset(widget.urlIcon),
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

  // Widget textField() {
  //   return TextField(
  //     maxLines: widget.maxLine,
  //     style: textNormal(titleColor, 16),
  //     decoration: InputDecoration(
  //       hintText: widget.hintText,
  //       hintStyle: textNormal(textBodyTime, 16),
  //       border: InputBorder.none,
  //       isDense: true,
  //       contentPadding: EdgeInsets.zero,
  //     ),
  //   );
  // }

  Widget textFromField() {
    return Form(
      key: key,
      child: TextFormField(
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
        style: textNormal(color3D5586, 16),
        enabled: widget.isEnabled,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: textNormal(textBodyTime, 16),
          contentPadding: EdgeInsets.zero,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          fillColor: widget.isEnabled
              ? widget.fillColor ?? Colors.transparent
              : borderColor.withOpacity(0.3),
          filled: false,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
            //  borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
            //  borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
            // borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
            // borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: backgroundColorApp),
            //  borderRadius: BorderRadius.all(Radius.circular(6)),
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
