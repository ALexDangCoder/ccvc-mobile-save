import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseSearchBar extends StatelessWidget {
  const BaseSearchBar({
    Key? key,
    this.focusNode,
    this.onSubmit,
    this.onChange,
    this.controller,
    this.hintText,
  }) : super(key: key);
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffDBDFEF),
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.black,
        style: tokenDetailAmount(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          isCollapsed: true,
          prefixIcon:  Icon(
            Icons.search,
            color:AppTheme.getInstance().colorField(),
          ),
          border: InputBorder.none,
          hintText: hintText ?? S.current.enterkeysearch,
          hintStyle: const TextStyle(
            color: Color(0xffA2AEBD),
            fontSize: 14,
          ),
        ),
        onChanged: (searchText) {
          onChange != null ? onChange!(searchText) : null;
        },
        onSubmitted: (searchText) {
          onSubmit != null ? onSubmit!(searchText) : null;
        },
      ),
    );
  }
}
