import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/ngay_bach_ky_widget.dart';
import 'package:flutter/material.dart';

class ThapNhiKienTruWidget extends StatelessWidget {
  final ThapNhiKienTru thapNhiKienTru;

  const ThapNhiKienTruWidget({
    Key? key,
    required this.thapNhiKienTru,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.thap_nhi_kien_tru,
            style: textNormalCustom(
              fontSize: 16.0,
              color: color3D5586,
            ),
          ),
        ),
        titleNgayBachKy(
          '${S.current.truc}: ',
          thapNhiKienTru.truc ?? '',
        ),
        titleNgayBachKy(
          '${S.current.nen_lam}: ',
          thapNhiKienTru.nenLam ?? '',
          color: colorNenLam,
        ),
        titleNgayBachKy(
          '${S.current.khong_nen_lam}: ',
          thapNhiKienTru.khongNenLam ?? '',
          color: specialPriceColor,
        ),
      ],
    );
  }
}
