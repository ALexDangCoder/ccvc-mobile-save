import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/list_row_data.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class TabTienTrinhXuLyTablet extends StatefulWidget {
  const TabTienTrinhXuLyTablet({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  @override
  State<TabTienTrinhXuLyTablet> createState() => _TabTienTrinhXuLyTabletState();
}

class _TabTienTrinhXuLyTabletState extends State<TabTienTrinhXuLyTablet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getTienTrinhXyLy(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () {},
      child: _content(),
    );
  }

  Widget _content() {
    return StreamBuilder <List<List<ListRowYKND>>>(
      stream: widget.cubit.tienTrinhXuLyRowData,
      builder: (context, snapshot){
        final data= snapshot.data??[];
        if(data.isNotEmpty){
          return Padding(
            padding: const EdgeInsets.only(top: 28.0,left: 14.0,right: 14.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, indexItem){
                return  Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 28, left: 16, right: 16),
                  decoration:  BoxDecoration(
                    color: bgTabletItem,
                    border: Border.all(color: cellColorborder),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        color: shadowContainerColor.withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      )
                    ],
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
              } ,
            ),
          );
        }
        else{
          return const NodataWidget();
        }
      },

    );
  }

  Container _itemTienTrinhXuLy() {
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
              title: S.current.thoi_gian_thao_tac,
              description: '23:27 16/09/2021'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.don_vi_thao_tac, description: 'UBND Đồng Nai'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.tai_khoan_thao_tac, description: 'Chuyên viên'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.trang_thai_xu_ly, description: 'Đã tạo PAKN'),
          spaceH10,
          RowTitleFeatDescription(
              title: S.current.noi_dung_xu_ly, description: 'Không có'),
        ],
      ),
    );
  }
}
