import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';

class TabThongTinXuLyPAKNTablet extends StatefulWidget {
  const TabThongTinXuLyPAKNTablet({Key? key, required this.cubit, required this.id, required this.taskId,}) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  final String taskId;
  @override
  State<TabThongTinXuLyPAKNTablet> createState() =>
      _TabThongTinXuLyPAKNTabletState();
}

class _TabThongTinXuLyPAKNTabletState extends State<TabThongTinXuLyPAKNTablet> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getThongTinXuLyPAKN(widget.id, widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
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
        spaceH10,
        RowTitleFeatDescription(
            title: S.current.noi_dung_xu_ly, description: fakeData[2]),
      ],
    );
  }
}
