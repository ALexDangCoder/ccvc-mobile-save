import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/gio_hoang_dao_widget.dart';
import 'package:flutter/material.dart';

class TuoiXungTheoNgayWidget extends StatelessWidget {
  final List<TuoiXungTheoNgay> listTuoiXungTheoNgay;

  const TuoiXungTheoNgayWidget({
    Key? key,
    required this.listTuoiXungTheoNgay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            S.current.tuoi_xung_theo_ngay,
            style: textNormalCustom(
              fontSize: 16.0,
              color: color3D5586,
            ),
          ),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 4,
          children: List.generate(listTuoiXungTheoNgay.length, (index) {
            return icon12ConGiap(
              listTuoiXungTheoNgay[index].toIcon(),
              listTuoiXungTheoNgay[index].tenTuoi ?? '',
              listTuoiXungTheoNgay[index].nguHanh ?? '',
            );
          }),
        ),
      ],
    );
  }
}
