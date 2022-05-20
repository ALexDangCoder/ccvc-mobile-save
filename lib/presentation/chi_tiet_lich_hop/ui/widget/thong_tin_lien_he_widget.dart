import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ThongTinLienHeWidget extends StatelessWidget {
  final String thongTinTxt;
  final String sdtTxt;
  const ThongTinLienHeWidget({
    Key? key,
    this.thongTinTxt = '',
    this.sdtTxt = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.thong_tin_lien_he,
          style: textNormalCustom(color: color667793, fontSize: 16),
        ),
        SizedBox(
          height: 16.0.textScale(space: 8),
        ),
        RowDataWidget(
          text: thongTinTxt,
          urlIcon: ImageAssets.icPeople,
        ),
        SizedBox(
          height: 16.0.textScale(space: 8),
        ),
        RowDataWidget(
          urlIcon: ImageAssets.icCalling,
          text: sdtTxt,
        )
      ],
    );
  }
}
