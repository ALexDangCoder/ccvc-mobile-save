import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/ngay_bach_ky_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class SaoTotSaoXauWidget extends StatelessWidget {
  final List<SaoTot> listSaoTot;
  final List<SaoXau> listSaoXau;

  const SaoTotSaoXauWidget({
    Key? key,
    required this.listSaoTot,
    required this.listSaoXau,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.sao_tot_sao_xau,
            style: textNormalCustom(
              fontSize: 16.0,
              color: color3D5586,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.sao_tot,
            style: textNormalCustom(
              fontSize: 14.0.textScale(),
              color: color27AE60,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listSaoTot.length,
          itemBuilder: (context, index) {
            return titleNgayBachKy(
              listSaoTot[index].tenSao ?? '',
              listSaoTot[index].thongTin ?? '',
              color:color3D5586,
              isLine: true,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.sao_xau,
            style: textNormalCustom(
              fontSize: 14.0.textScale(),
              color: colorEB5757,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listSaoXau.length,
          itemBuilder: (context, index) {
            return titleNgayBachKy(
              listSaoXau[index].tenSao ?? '',
              listSaoXau[index].thongTin ?? '',
              color:color3D5586,
              isLine: true,
            );
          },
        ),

      ],
    );
  }
}
