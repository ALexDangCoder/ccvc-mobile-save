import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/tablet/chi_tiet_cong_viec_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/widget/cell_danh_sach_cong_viec_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DanhSachCongViecTablet extends StatefulWidget {
  final bool isCheck;
  final String ngayBatDau;
  final String ngayKetThuc;

  const DanhSachCongViecTablet({
    Key? key,
    required this.isCheck,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  }) : super(key: key);

  @override
  _DanhSachCongViecTabletState createState() => _DanhSachCongViecTabletState();
}

class _DanhSachCongViecTabletState extends State<DanhSachCongViecTablet> {
  NhiemVuCubit cubit = NhiemVuCubit();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  final DanhSachCubit danhSachCubit = DanhSachCubit();

  @override
  void initState() {
    super.initState();
    danhSachCubit.apiDanhSachCongViecCaNhan(
      widget.ngayBatDau,
      widget.ngayKetThuc,
      widget.isCheck,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.danh_sach_cong_viec),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 28,
                top: 28,
              ),
              child: _content(),
            ),
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
        danhSachCubit.postDanhSachCongViec(
          hanXuLy: {
            'FromDate': widget.ngayBatDau,
            'ToDate': widget.ngayKetThuc
          },
          index: page,
          isCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          keySearch: danhSachCubit.keySearch,
          mangTrangThai: [],
          size: danhSachCubit.pageSize,
          trangThaiHanXuLy: '',
        )
      },
      viewItem: (value, index) {
        try {
          return CellDanhSachCongViecTablet(
            data: value as PageDatas,
            index: index ?? 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChitietCongViecNhiemVuTablet(
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
