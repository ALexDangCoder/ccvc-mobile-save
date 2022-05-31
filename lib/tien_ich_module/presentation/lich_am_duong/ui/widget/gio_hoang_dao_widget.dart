import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GioHoangDaoWidget extends StatelessWidget {
  final List<GioHoangDao> listGioHoangDao;
  final String hanh;
  final String truc;
  final String sao;

  const GioHoangDaoWidget({
    Key? key,
    required this.listGioHoangDao,
    required this.hanh,
    required this.truc,
    required this.sao,
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
                color: choVaoSoColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              S.current.gio_hoang_dao_gio_tot,
              style: textNormalCustom(
                fontSize: 14.0,
                color: color3D5586,
                fontWeight: FontWeight.w400,
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
          children: List.generate(listGioHoangDao.length, (index) {
            return icon12ConGiap(
              listGioHoangDao[index].toIcon(),
              listGioHoangDao[index].ten ?? '',
              listGioHoangDao[index].gio ?? '',
            );
          }),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleWidget(S.current.hanh, hanh),
              titleWidget(S.current.truc, truc),
              titleWidget(S.current.sao, sao),
            ],
          ),
        ),
      ],
    );
  }
}

Widget titleWidget(String title, String value) {
  return Row(
    children: [
      Text(
        '$title: ',
        style: textNormalCustom(
          fontSize: 14.0.textScale(),
          color: AqiColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        value,
        style: textNormalCustom(
          fontSize: 14.0.textScale(),
          color: color3D5586,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget icon12ConGiap(String url, String ten, String gio) {
  return Padding(
    padding: const EdgeInsets.only(right: 24.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          url,
          width: 32.0.textScale(),
          height: 32.0.textScale(),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ten,
              style: textNormalCustom(
                fontSize: 12.0.textScale(),
                color: color3D5586,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              gio,
              style: textNormalCustom(
                fontSize: 12.0.textScale(),
                color: iconColorDown,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
