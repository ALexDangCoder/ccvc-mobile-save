import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;

  const SearchWidget({Key? key, this.hintText}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.0.textScale(),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(3),
            hintText:widget.hintText ??S.current.nhap_tu_khoa_tim_kiem,
            hintStyle: textNormalCustom(
                fontWeight: FontWeight.w400,
                fontSize: 14.0.textScale(),
                color: unselectLabelColor,),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: borderItemCalender,),
              borderRadius: BorderRadius.circular(6.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.indigoAccent,),
              borderRadius: BorderRadius.circular(6.0),
            ),
            prefixIcon:  Icon(
              Icons.search,
              color: AppTheme.getInstance().colorField(),
            ),),
      ),
    );
  }
}
