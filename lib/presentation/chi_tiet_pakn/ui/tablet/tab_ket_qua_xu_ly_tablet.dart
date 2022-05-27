import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/list_row_data.dart';
import 'package:flutter/material.dart';

class TabKetQuaXuLyTablet extends StatefulWidget {
  const TabKetQuaXuLyTablet({
    Key? key,
    required this.id,
    required this.taskId,
    required this.cubit,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  final String taskId;

  @override
  State<TabKetQuaXuLyTablet> createState() => _TabKetQuaXuLyTabletState();
}

class _TabKetQuaXuLyTabletState extends State<TabKetQuaXuLyTablet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getKetQuaXuLy(widget.id, widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 30.0),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return StreamBuilder<List<List<ListRowYKND>>>(
      stream: widget.cubit.ketQuaXuLyRowData,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        if (data.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, indexItem) {
              return Container(
                padding: const EdgeInsets.only(left: 16, top: 16),
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: bgDropDown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: bgDropDown),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data[indexItem].length,
                  itemBuilder: (context, index) {
                    return ListItemRow(
                      title: data[indexItem][index].title,
                      content: data[indexItem][index].content,
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: NodataWidget(),
          );
        }
      },
    );
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
              title: S.current.chuyen_vien_xu_ly, description: 'Nguyễn Văn A'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.don_vi_xu_ly, description: 'UBND Đồng Nai'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.vai_tro_xu_ly, description: 'Chuyên viên'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.trang_thai_xu_ly, description: 'Đã tạo PAKN'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.noi_dung_xu_ly, description: 'Không có'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.so_hieu_van_ban, description: 'M123'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.ngay_ban_hanh, description: '16/09/2021'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.trich_yeu, description: 'Không có'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.co_quan_ban_hanh, description: 'UBND Đồng Nai'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.file_dinh_kem, description: 'file.pdf'),
        ],
      ),
    );
  }
}
