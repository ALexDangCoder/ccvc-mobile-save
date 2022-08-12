import 'dart:io';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBarDocumentManagement extends StatefulWidget {
  final QLVBCCubit qlvbCubit;
  final String initKeyWord;
  final bool isTablet;

  const SearchBarDocumentManagement({
    Key? key,
    required this.qlvbCubit,
    this.initKeyWord = '',
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<SearchBarDocumentManagement> createState() =>
      _SearchBarDocumentManagementState();
}

class _SearchBarDocumentManagementState
    extends State<SearchBarDocumentManagement> {
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    textController.text = widget.initKeyWord;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (Platform.isIOS && !widget.isTablet)
          ? const EdgeInsets.only(top: 12)
          : EdgeInsets.zero,
      child: Container(
        margin:
            widget.isTablet ? EdgeInsets.zero : const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: widget.isTablet
              ? Border(
                  bottom: BorderSide(
                    color: cellColorborder,
                  ),
                )
              : Border.all(
                  color: cellColorborder,
                ),
        ),
        child: TextFormField(
          controller: textController,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: colorBlack,
          style: textNormalCustom(
            color: colorBlack,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            isCollapsed: true,
            suffixIcon: textController.value.text.isNotEmpty
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          textController.clear();
                          setState(() {});
                          widget.qlvbCubit.keySearch =
                              textController.value.text;
                          eventBus.fire(RefreshList());
                        },
                        child: const Icon(Icons.clear, color: coloriCon),
                      ),
                    ),
                  )
                : const SizedBox(),
            prefixIcon: widget.isTablet
                ? Padding(
                    padding: widget.isTablet
                        ? const EdgeInsets.only(right: 20)
                        : EdgeInsets.zero,
                    child: SvgPicture.asset(
                      ImageAssets.ic_KinhRong,
                      color: AppTheme.getInstance().colorField(),
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if(textController.text.trim().isNotEmpty){
                        textController.clear();
                        setState(() {});
                        widget.qlvbCubit.keySearch =
                            textController.value.text;
                        eventBus.fire(RefreshList());
                      }
                      widget.qlvbCubit.setSelectSearch();
                    },
                    child: ImageAssets.svgAssets(
                      ImageAssets.icBack,
                      color: coloriCon,
                    ),
                  ),
            prefixIconConstraints: widget.isTablet
                ? const BoxConstraints(
                    minWidth: 26,
                    minHeight: 26,
                  )
                : null,
            border: InputBorder.none,
            hintText: S.current.tim_kiem,
            hintStyle: const TextStyle(
              color: coloriCon,
              fontSize: 14,
            ),
          ),
          onFieldSubmitted: (value){
            widget.qlvbCubit.keySearch = value;
            eventBus.fire(RefreshList());
          },
          onChanged: (value){
            setState(() {

            });
          },
        ),
      ),
    );
  }
}
