import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  final bool isPass;
  final String? textHint;
  final Widget? prefixIcon;
  final Function(String text)? onChange;
  final Function(String text)? onSubmit;
  final String? Function(String?)? validate;
  final double? sizeWith;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.onChange,
    this.onSubmit,
    this.textHint,
    this.prefixIcon,
    this.validate,
    this.sizeWith,
    required this.isPass,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.sizeWith,
      child: TextFormField(
        controller: widget.controller,
        obscureText:
            widget.isPass == true ? obscureText == false : obscureText == true,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.black12,
        style: textNormalCustom(
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.normal,
            color: color000000),
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: widget.prefixIcon!,
            onPressed: () {},
          ),
          suffixIcon: Visibility(
            visible: widget.isPass,
            child: IconButton(
              icon: obscureText
                  ? SvgPicture.asset(ImageAssets.imgView)
                  : SvgPicture.asset(ImageAssets.imgViewHide),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 20),
          isCollapsed: true,
          fillColor: colorE2E8F0.withOpacity(0.1),
          filled: true,
          hintText: widget.textHint,
          hintStyle: textNormalCustom(
            fontSize: 14.0.textScale(),
            color: color667793,
            fontWeight: FontWeight.w400,
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: colorF94444),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: colorE2E8F0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: colorE2E8F0),
          ),
        ),
        onChanged: (text) {
          widget.onChange != null ? widget.onChange!(text) : null;
        },
        validator: widget.validate,
        onFieldSubmitted: (text) {
          widget.onSubmit != null ? widget.onSubmit!(text) : null;
        },
      ),
    );
  }
}
