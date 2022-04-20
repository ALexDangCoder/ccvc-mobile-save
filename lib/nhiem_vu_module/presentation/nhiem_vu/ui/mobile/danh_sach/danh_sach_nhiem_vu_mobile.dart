import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';

class DanhSachNhiemVuMobile extends StatefulWidget {
  final bool isCheck;
  final String ngayBatDau;
  final String ngayKetThuc;
  final List<String> mangTrangThai;
final int? trangThaiHanXuLy;
  const DanhSachNhiemVuMobile({
    Key? key,
    required this.isCheck,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.mangTrangThai,
    this.trangThaiHanXuLy,
  }) : super(key: key);

  @override
  _DanhSachNhiemVuMobileState createState() => _DanhSachNhiemVuMobileState();
}

class _DanhSachNhiemVuMobileState extends State<DanhSachNhiemVuMobile> {
  final DanhSachCubit cubit = DanhSachCubit();

  @override
  void initState() {
    super.initState();
    cubit.apiDanhSachNhiemVuCaNhan(
      widget.ngayBatDau,
      widget.ngayKetThuc,
      widget.isCheck,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_nhiem_vu),
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
        cubit.postDanhSachNhiemVu(
          index: page,
          isNhiemVuCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          mangTrangThai: widget.mangTrangThai,
          ngayTaoNhiemVu: {
            'FromDate': cubit.ngayDauTien,
            'ToDate': cubit.ngayKetThuc
          },
          size: cubit.pageSize,
          keySearch: cubit.keySearch,
        )
      },
      viewItem: (value, index) {
        try {
          return NhiemVuItemMobile(
            data: value as PageData,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChiTietNhiemVuPhoneScreen(
                    id: value.id ?? '',
                    isCheck: widget.isCheck,
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
