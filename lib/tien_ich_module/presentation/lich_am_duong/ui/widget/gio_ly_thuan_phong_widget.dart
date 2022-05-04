import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class GioLyThuanPhongWidget extends StatelessWidget {
  final List<GioLyThuanPhong> listGioLyThuanPhong;

  const GioLyThuanPhongWidget({
    Key? key,
    required this.listGioLyThuanPhong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.gio_ly_thuan_phong,
            style: textNormalCustom(
              fontSize: 16.0,
              color: titleColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listGioLyThuanPhong.length,
          itemBuilder: (context,index){
            return titleGioLyThuanPhong(
              listGioLyThuanPhong[index].ten??'',
              listGioLyThuanPhong[index].moTa??'',
            );
          },
        )
      ],
    );
  }
}

Widget titleGioLyThuanPhong(String title, String values) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textNormalCustom(
            color:  AppTheme.getInstance().colorField(),
            fontWeight: FontWeight.w500,
            fontSize: 14.0.textScale(),
          ),
        ),
        const SizedBox(height: 6.0,),
        Text(
          values,
          style: textNormalCustom(
            color:  titleColor,
            fontWeight: FontWeight.w400,
            fontSize: 14.0.textScale(),
          ),
        )
      ],
    ),
  );
}
