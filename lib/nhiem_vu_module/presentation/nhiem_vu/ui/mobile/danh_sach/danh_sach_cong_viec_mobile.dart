import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/mobile/chi_tiet_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/cell_cong_viec.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecMobile extends StatefulWidget {
  final bool isCheck;
  final String ngayBatDau;
  final String ngayKetThuc;
  final List<String> mangTrangThai;
  final int? trangThaiHanXuLy;

  const DanhSachCongViecMobile({
    Key? key,
    required this.isCheck,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.mangTrangThai,
    required this.trangThaiHanXuLy,
  }) : super(key: key);

  @override
  _DanhSachCongViecMobileState createState() => _DanhSachCongViecMobileState();
}

class _DanhSachCongViecMobileState extends State<DanhSachCongViecMobile> {
  final DanhSachCubit cubit = DanhSachCubit();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_cong_viec),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16.0,
            ),
            BaseSearchBar(
              onChange: (value) {
                cubit.debouncer.run(() {
                  setState(() {});
                  cubit.keySearch = value;
                });
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 16),
                child: _content(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: true,
      callApi: (page) => {
        cubit.postDanhSachCongViec(
          hanXuLy: {
            'FromDate': widget.ngayBatDau,
            'ToDate': widget.ngayKetThuc
          },
          index: page,
          isCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          keySearch: cubit.keySearch,
          mangTrangThai: widget.mangTrangThai,
          size: cubit.pageSize,
          trangThaiHanXuLy: widget.trangThaiHanXuLy,
        )
      },
      viewItem: (value, index) {
        try {
          return CellCongViec(
            data: value as PageDatas,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChitietCongViecNhiemVuMobile(
                    id: value.id ?? '',
                  ),
                ),
              );
            },
          );
        } catch (e) {
          return const SizedBox();
        }
      },
    );
  }
}
