import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/widget/cell_danh_sach_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DanhSachNhiemVuTablet extends StatefulWidget {
  final bool isCheck;
  final String ngayBatDau;
  final String ngayKetThuc;
  final List<String> mangTrangThai;
  final int? trangThaiHanXuLy;
  const DanhSachNhiemVuTablet({
    Key? key,
    required this.isCheck,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.mangTrangThai,
    this.trangThaiHanXuLy
  }) : super(key: key);

  @override
  _DanhSachNhiemVuTabletState createState() => _DanhSachNhiemVuTabletState();
}

class _DanhSachNhiemVuTabletState extends State<DanhSachNhiemVuTablet> {
  NhiemVuCubit cubit = NhiemVuCubit();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  final DanhSachCubit danhSachCubit = DanhSachCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.danh_sach_nhiem_vu),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _content(),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: danhSachCubit,
      isListView: true,
      callApi: (page) => {
        danhSachCubit.postDanhSachNhiemVu(
          index: page,
          isNhiemVuCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          mangTrangThai: widget.mangTrangThai,
          ngayTaoNhiemVu: {
            'FromDate': widget.ngayBatDau,
            'ToDate': widget.ngayKetThuc
          },
          size: danhSachCubit.pageSize,
          keySearch: danhSachCubit.keySearch,
          trangThaiHanXuLy: widget.trangThaiHanXuLy,
        )
      },
      viewItem: (value, index) {
        try {
          return Container(
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
            ),
            margin:
                index == 0 ? const EdgeInsets.only(top: 24) : EdgeInsets.zero,
            child: CellDanhSachNhiemVuTablet(
              data: value as PageData,
              index: index ?? 0,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChiTietNhiemVuTabletScreen(
                      id: value.id ?? '',
                      isCheck: widget.isCheck,
                    ),
                  ),
                );
              },
            ),
          );
        } catch (e) {
          return const SizedBox();
        }
      },
    );
  }
}
