import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/thong_tin_nguoi_phan_anh.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/thong_tin_xu_ly_phan_anh.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/tien_trinh_xu_Ly.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanTabletScreen extends StatefulWidget {
  const ChiTietVanBanTabletScreen({Key? key}) : super(key: key);

  @override
  _ChiTietVanBanTabletScreenState createState() =>
      _ChiTietVanBanTabletScreenState();
}

class _ChiTietVanBanTabletScreenState extends State<ChiTietVanBanTabletScreen> {
  ChiTietYKienNguoiDanCubit cubit = ChiTietYKienNguoiDanCubit();

  @override
  void initState() {
    super.initState();
    cubit.getMapDataKetQuaXuLy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 28.0, right: 28.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: Column(
                        children: [
                          StreamBuilder<List<DataRowChiTietKienNghi>>(
                            stream: cubit.headerChiTiet,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? [];
                              return ChiTietYKNDHeader(
                                listRow: data,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          ExpandOnlyNhiemVu(
                            name: S.current.thong_tin_nguoi_phan_anh,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: ThongTinNguoiPhanAnhTablet(
                                cubit: cubit,
                              ),
                            ),
                          ),
                          ExpandOnlyNhiemVu(
                            name: S.current.thong_tin_xu_ly_phan_anh,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: ThongTinXuLyPhanAnh(
                                cubit: cubit,
                              ),
                            ),
                          ),
                          ExpandOnlyNhiemVu(
                            name: S.current.ket_qua_xu_ly,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
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
                  // const SizedBox(width: 30.0,),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
