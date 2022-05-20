import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/gio_hoang_dao_widget.dart';
import 'package:flutter/material.dart';

class TuoiXungTheoThangWidget extends StatelessWidget {
  final List<TuoiXungTheoThang> listTuoiXungTheoThang;

  const TuoiXungTheoThangWidget({
    Key? key,
    required this.listTuoiXungTheoThang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            S.current.tuoi_xung_theo_thang,
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
          children: List.generate(listTuoiXungTheoThang.length, (index) {
            return icon12ConGiap(
              listTuoiXungTheoThang[index].toIcon(),
              listTuoiXungTheoThang[index].tenTuoi ?? '',
              listTuoiXungTheoThang[index].nguHanh ?? '',
            );
          }),
        ),

      ],
    );
  }
}
