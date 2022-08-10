import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderTabletCalendarWidget extends StatefulWidget {
  final String time;
  final Function() onTap;
  final Function(String) onSearch;
  final TextEditingController controller;

  const HeaderTabletCalendarWidget({
    Key? key,
    required this.time,
    required this.onTap,
    required this.onSearch,
    required this.controller,
  }) : super(key: key);

  @override
  State<HeaderTabletCalendarWidget> createState() =>
      _HeaderTabletCalendarWidgetState();
}

class _HeaderTabletCalendarWidgetState extends State<HeaderTabletCalendarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController expandController;
  late Animation<double> animation;
  late Animation<double> animationSearch;
  bool isSearch = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..value = 1;
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animationSearch = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: expandController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            child: GestureDetector(
              onTap: () {
                widget.onTap();
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Text(
                      widget.time,
                      style: textNormalCustom(
                        fontSize: 14,
                        color: titleCalenderWork,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: textBodyTime,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: SizeTransition(
              sizeFactor: animationSearch,
              axis: Axis.horizontal,
              child: textFileSearch(),
            ),
          ),
          AnimatedBuilder(
            builder: (context, _) => GestureDetector(
              onTap: () {
                if (isSearch) {
                  focusNode.unfocus();
                  widget.controller.text = '';
                  widget.onSearch(widget.controller.text);
                  expandController.forward();
                } else {
                  expandController.reverse();
                }
                isSearch = !isSearch;
              },
              child: Stack(
                children: [
                  Opacity(
                    opacity: animation.value,
                    child: SvgPicture.asset(ImageAssets.ic_search_calendar),
                  ),
                  Opacity(
                    opacity: animationSearch.value,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(
                        Icons.close,
                        color: colorA2AEBD,
                      ),
                    ),
                  )

                  // Icon(Icons.close)
                ],
              ),
            ),
            animation: animation,
          )
        ],
      ),
    );
  }

  Widget textFileSearch() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        style: tokenDetailAmount(
          fontSize: 14.0.textScale(),
          color: color3D5586,
        ),
        onFieldSubmitted: (value) {
          widget.onSearch(value.trim());
        },
        decoration: InputDecoration(
          counterText: '',
          hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          filled: true,
          fillColor: Colors.white,
          hintText: S.current.nhap_tu_khoa_tim_kiem,
          prefixIcon: IconButton(
            onPressed: () {
              widget.onSearch(widget.controller.value.text.trim());
            },
            icon: Icon(
              Icons.search,
              color: AppTheme.getInstance().colorField(),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: borderItemCalender),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderItemCalender),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderItemCalender),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderItemCalender),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderItemCalender),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
    );
  }
}
