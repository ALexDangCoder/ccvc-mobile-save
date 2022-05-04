import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NgayBachKyWidget extends StatelessWidget {
  final List<NgayBachKy> listNgayBachKy;

  const NgayBachKyWidget({Key? key, required this.listNgayBachKy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.ngay_back_ky,
            style: textNormalCustom(
              fontSize: 16.0,
              color: titleColor,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listNgayBachKy.length,
          itemBuilder: (context, index) {
            return titleNgayBachKy(
              listNgayBachKy[index].ten ?? '',
              listNgayBachKy[index].moTa ?? '',
            );
          },
        ),
      ],
    );
  }
}

Widget titleNgayBachKy(String title, String value,
    {Color? color, FontWeight? fontWeight, bool? isLine}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: isLine == true ? '$title: ' : '$title ',
            style: textNormalCustom(
              color: color ?? AppTheme.getInstance().colorField(),
              fontWeight: fontWeight ?? FontWeight.w700,
              fontSize: 14.0.textScale(),
            ),
          ),
          TextSpan(
            text: value,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              color: titleColor,
              fontSize: 14.0.textScale(),
            ),
          ),
        ],
      ),
    ),
  );
}
