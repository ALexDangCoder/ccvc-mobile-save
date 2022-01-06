import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseSearchBar extends StatelessWidget {
  const BaseSearchBar({Key? key,  this.focusNode,this.onSubmit, this.onChange, this.controller})
      : super(key: key);
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final FocusNode? focusNode;
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
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          isCollapsed: true,
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xff5F63E8),
          ),
          border: InputBorder.none,
          hintText: S.current.enterkeysearch,
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
