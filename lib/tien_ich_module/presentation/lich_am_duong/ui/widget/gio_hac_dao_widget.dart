import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/gio_hoang_dao_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GioHacDaoWidget extends StatelessWidget {
  final List<GioHacDao> listGioHacDao;


  const GioHacDaoWidget({
    Key? key,
    required this.listGioHacDao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 10.0,
              width: 10.0,
              decoration: const BoxDecoration(
                color: color28C76F,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              S.current.gio_hac_dao_gio_xau,
              style: textNormalCustom(
                fontSize: 14.0,
                color: color3D5586,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 4,
          children: List.generate(listGioHacDao.length, (index) {
            return icon12ConGiap(
              listGioHacDao[index].toIcon(),
              listGioHacDao[index].ten ?? '',
              listGioHacDao[index].gio ?? '',
            );
          }),
        ),
        const SizedBox(
          width: 16.0,
        ),
      ],
    );
  }
}

