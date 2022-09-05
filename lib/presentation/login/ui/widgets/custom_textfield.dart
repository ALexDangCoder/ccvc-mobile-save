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
            color: colorBlack),
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
          fillColor: bgDropDown.withOpacity(0.1),
          filled: true,
          hintText: widget.textHint,
          hintStyle: textNormalCustom(
            fontSize: 14.0.textScale(),
            color: color667793,
            fontWeight: FontWeight.w400,
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: canceledColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: bgDropDown),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: bgDropDown),
          ),
        ),
        onChanged: widget.onChange,
        validator: widget.validate,
        onFieldSubmitted: widget.onSubmit,
      ),
    );
  }
}
