import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/ngay_bach_ky_widget.dart';
import 'package:flutter/material.dart';


class ThapNhiBatTuWidget extends StatelessWidget {
  final ThapNhiBatTu thapNhiBatTu;

  const ThapNhiBatTuWidget({
    Key? key,
    required this.thapNhiBatTu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.theo_nhi_thap_bat_tu,
            style: textNormalCustom(
              fontSize: 16.0,
              color: color3D5586,
            ),
          ),
        ),
        titleNgayBachKy(
          '${S.current.tinh_moc_han_dieu_ky}: ',
          thapNhiBatTu.totXau ?? '',
          color: colorNenLam,
        ),
        titleNgayBachKy('${S.current.nen_lam}: ', thapNhiBatTu.nenLam ?? '',
            color: colorNenLam,),
        titleNgayBachKy(
          '${S.current.kieng_cu}: ',
          thapNhiBatTu.kieng ?? '',
          color: specialPriceColor,
        ),
        titleNgayBachKy(
          '${S.current.ngoai_le}: ',
          thapNhiBatTu.ngoaiLe ?? '',
        ),
      ],
    );
  }
}
