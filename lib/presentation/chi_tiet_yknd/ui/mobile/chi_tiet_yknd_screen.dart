import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/widget_expand_yknd_mobile/y_kien_xu_ly_pakn_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/thong_tin_nguoi_phan_anh.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/tien_trinh_xu_Ly.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietYKNDScreen extends StatefulWidget {
  final String iD;
  final String taskID;

  const ChiTietYKNDScreen({Key? key, required this.iD, required this.taskID})
      : super(key: key);

  @override
  _ChiTietYKNDScreenState createState() => _ChiTietYKNDScreenState();
}

class _ChiTietYKNDScreenState extends State<ChiTietYKNDScreen>
    with SingleTickerProviderStateMixin {
  ChiTietYKienNguoiDanCubit cubit = ChiTietYKienNguoiDanCubit();

  @override
  void initState() {
    super.initState();
    cubit.getchiTietYKienNguoiDan(widget.iD, widget.taskID);
    cubit.getDanhSachYKienXuLyPAKN(widget.iD);
    cubit.getTienTrinhXyLy(widget.iD);
    cubit.getKetQuaXuLy(widget.iD, widget.taskID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.chi_tiet_yknd,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          cubit.getchiTietYKienNguoiDan(widget.iD, widget.taskID);
          cubit.getDanhSachYKienXuLyPAKN(widget.iD);
          cubit.getTienTrinhXyLy(widget.iD);
          cubit.getKetQuaXuLy(widget.iD, widget.taskID);
        },
        error: AppException('', S.current.something_went_wrong),
        stream: cubit.stateStream,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: ChiTietYKNDHeader(
                  cubit: cubit,
                ),
              ),
              StreamBuilder<ChiTietYKienNguoiDanRow>(
                stream: cubit.rowDataChiTietYKienNguoiDan,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return Column(
                    children: [
                      ExpandOnlyNhiemVu(
                        name: S.current.thong_tin_nguoi_phan_anh,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: ThongTinNguoiPhanAnh(
                            indexCheck: cubit.checkIndex,
                            listRow: data?.thongTinPhanAnhRow ?? [],
                          ),
                        ),
                      ),
                      ExpandOnlyNhiemVu(
                        name: S.current.ket_qua_xu_ly,
                        child: Column(
                          children: [
                            KetQuaXuLyScreen(
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                      ExpandOnlyNhiemVu(
                        name: S.current.tien_trinh_xu_ly,
                        child: Column(
                          children: [
                            TienTrinhXuLyScreen(
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                      YKienXuLyPAKNWidgetExpand(
                        cubit: cubit,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
