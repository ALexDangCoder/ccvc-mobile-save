import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_xy_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class TabThongTinXuLyPAKNTablet extends StatefulWidget {
  const TabThongTinXuLyPAKNTablet({
    Key? key,
    required this.cubit,
    required this.id,
    required this.taskId,
  }) : super(key: key);
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
    super.initState();
    widget.cubit.getThongTinXuLyPAKN(
      widget.id,
      widget.taskId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () {},
      child: StreamBuilder<ThongTinXuLyPAKNModel>(
        stream: widget.cubit.listThongTinXuLy.stream,
        builder: (context, snapshot) {
          final data = snapshot.data?.donViDuocPhanXuLy ?? [];
          if (data.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return itemThongTinXuLyPAKN(data[index]);
              },
            );
          } else {
            return const NodataWidget();
          }
        },
      ),
    );
  }

  Widget itemThongTinXuLyPAKN(DonViDuocPhanXuLyModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
        color: containerColorTab,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          RowTitleFeatDescription(
              title: S.current.ten_don_vi_cheo_phong_ban,
              description: model.tenDonVi),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.vai_tro, description: model.vaiTro),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.hoat_dong, description: model.hoatDong),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.noi_dung_xu_ly, description: model.noiDungXuLy),
        ],
      ),
    );
  }
}
