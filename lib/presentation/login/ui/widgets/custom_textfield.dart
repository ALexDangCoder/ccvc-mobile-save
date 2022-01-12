import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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

  const CustomTextField(
      {Key? key,
      this.onChange,
      this.onSubmit,
      this.textHint,
      this.prefixIcon,
      required this.isPass})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:
          widget.isPass == true ? obscureText == false : obscureText == true,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Colors.black12,
      style:  TextStyle(
        fontSize: 14.0.textScale(),
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: SizedBox(width: 50, height: 14, child: widget.prefixIcon),
        prefixIconConstraints:  BoxConstraints(
          maxWidth: 40.0.textScale(space: 16.0),
          maxHeight: 14,
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
            color: unselectedLabelColor,
            fontWeight: FontWeight.w400),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: Colors.red),
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
      onChanged: (text) {
        widget.onChange != null ? widget.onChange!(text) : null;
      },
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return S.current.khong_the_bo_trong;
        }
        return null;
      },
      onFieldSubmitted: (text) {
        widget.onSubmit != null ? widget.onSubmit!(text) : null;
      },
    );
  }
}
