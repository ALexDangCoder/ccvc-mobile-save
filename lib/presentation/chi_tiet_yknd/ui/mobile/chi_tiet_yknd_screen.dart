import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/bottom_sheet_search_yknd.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/thong_tin_nguoi_phan_anh.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/thong_tin_xu_ly_phan_anh.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/tien_trinh_xu_Ly.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ChiTietYKNDScreen extends StatefulWidget {
  const ChiTietYKNDScreen({Key? key}) : super(key: key);

  @override
  _ChiTietYKNDScreenState createState() => _ChiTietYKNDScreenState();
}

class _ChiTietYKNDScreenState extends State<ChiTietYKNDScreen>
    with SingleTickerProviderStateMixin {
  ChiTietYKienNguoiDanCubit cubit = ChiTietYKienNguoiDanCubit();

  @override
  void initState() {
    super.initState();
    cubit.getMapDataKetQuaXuLy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.chi_tiet_yknd,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheetCustom(
            context,
            child: const BottomSheetSearchYKND(),
            title: S.current.tim_kiem,
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ChiTietYKNDHeader(
                  cubit: cubit,
                ),
              ),
              ExpandOnlyNhiemVu(
                name: S.current.thong_tin_nguoi_phan_anh,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ThongTinNguoiPhanAnh(
                    cubit: cubit,
                  ),
                ),
              ),
              ExpandOnlyNhiemVu(
                name: S.current.thong_tin_xu_ly_phan_anh,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ThongTinXuLyPhanAnh(
                    cubit: cubit,
                  ),
                ),
              ),
              ExpandOnlyNhiemVu(
                name: S.current.ket_qua_xu_ly,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      ItemRow(
                        title: S.current.y_kien_xu_ly,
                        content: cubit.yKienXuLy,
                      ),
                      KetQuaXuLyScreen(
                        cubit: cubit,
                      ),
                    ],
                  ),
                ),
              ),
              ExpandOnlyNhiemVu(
                name: S.current.tien_trinh_xu_ly,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      ItemRow(
                        title: S.current.y_kien_xu_ly,
                        content: cubit.yKienXuLy,
                      ),
                      TienTrinhXuLyScreen(
                        cubit: cubit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
