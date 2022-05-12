import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';
class TabKetQuaXuLy extends StatefulWidget {
  const TabKetQuaXuLy({Key? key}) : super(key: key);

  @override
  State<TabKetQuaXuLy> createState() => _TabKetQuaXuLyState();
}

class _TabKetQuaXuLyState extends State<TabKetQuaXuLy> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _itemKetQuaXuLy() {
    return Container(
      width: 343,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
        color: containerColorTab,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          RowTitleFeatDescription(
              title: S.current.ten_don_vi_cheo_phong_ban,
              description: fakeData[0]),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.vai_tro, description: fakeData[1]),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.hoat_dong, description: fakeData[2]),
        ],
      ),
    )
  }
}
