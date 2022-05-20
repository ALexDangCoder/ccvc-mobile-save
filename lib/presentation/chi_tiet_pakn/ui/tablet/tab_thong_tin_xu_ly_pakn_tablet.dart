import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

class TabThongTinXuLyPAKNTablet extends StatefulWidget {
  const TabThongTinXuLyPAKNTablet({Key? key}) : super(key: key);

  @override
  State<TabThongTinXuLyPAKNTablet> createState() => _TabThongTinXuLyPAKNTabletState();
}

class _TabThongTinXuLyPAKNTabletState extends State<TabThongTinXuLyPAKNTablet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Column(
        children: [
          itemThongTinXuLyPAKN(),

        ],
      ),
    );
  }

  List<String> fakeData = ['Phòng một cửa', 'Chủ trì', 'Tiếp nhận'];

  Widget itemThongTinXuLyPAKN() {
    return Column(
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
    );
  }
}
