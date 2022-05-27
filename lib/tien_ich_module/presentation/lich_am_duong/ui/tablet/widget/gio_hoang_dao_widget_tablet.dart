import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/gio_hoang_dao_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/ngay_bach_ky_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class GioHoangDaoWidgetTablet extends StatelessWidget {
  final List<GioHoangDao> listGioHoangDao;
  final String hanh;
  final String truc;
  final String sao;
  final String tietKhi;
  final String ngayAmLichStr;

  const GioHoangDaoWidgetTablet({
    Key? key,
    required this.listGioHoangDao,
    required this.hanh,
    required this.truc,
    required this.sao,
    required this.tietKhi,
    required this.ngayAmLichStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 24.0),
          child: Row(
            children: [
              Container(
                height: 10.0.textScale(),
                width: 10.0.textScale(),
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
                  fontSize: 14.0.textScale(),
                  color: color3D5586,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: listGioHoangDao.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: icon12ConGiap(
                    listGioHoangDao[index].toIcon(),
                    listGioHoangDao[index].ten ?? '',
                    listGioHoangDao[index].gio ?? '',
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleWidget(S.current.hanh, hanh),
                  spaceW56,
                  titleWidget(S.current.truc, truc),
                  spaceW56,
                  titleWidget(S.current.sao, sao),
                  spaceW56,
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: titleNgayBachKy(
                      '${S.current.tiet_khi}:',
                      tietKhi,
                      fontWeight: FontWeight.w400,
                      color: color3D5586,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
