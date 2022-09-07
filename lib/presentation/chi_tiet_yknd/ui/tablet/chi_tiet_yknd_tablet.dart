import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/widget_expand_yknd_mobile/y_kien_xu_ly_pakn_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/item_row.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/thong_tin_nguoi_phan_anh_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanTabletScreen extends StatefulWidget {
  final String iD;
  final String taskID;

  const ChiTietVanBanTabletScreen({
    Key? key,
    required this.taskID,
    required this.iD,
  }) : super(key: key);

  @override
  _ChiTietVanBanTabletScreenState createState() =>
      _ChiTietVanBanTabletScreenState();
}

class _ChiTietVanBanTabletScreenState extends State<ChiTietVanBanTabletScreen> {
  ChiTietYKienNguoiDanCubit cubit = ChiTietYKienNguoiDanCubit();

  @override
  void initState() {
    super.initState();
    // cubit.getchiTietYKienNguoiDan(widget.iD, widget.taskID);
    // cubit.getDanhSachYKienXuLyPAKN(widget.iD);
    cubit.getTienTrinhXyLy(widget.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(
        S.current.chi_tiet_yknd,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          cubit.getTienTrinhXyLy(widget.iD);
        },
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: cubit.stateStream,
        child: Container(
          padding: const EdgeInsets.only(top: 28, left: 30, right: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<ChiTietYKienNguoiDanRow>(
                stream: cubit.rowDataChiTietYKienNguoiDan,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(right: 14.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: backgroundColorApp,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: cellColorborder),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        shadowContainerColor.withOpacity(0.05),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            ExpandOnlyNhiemVu(
                              name: S.current.thong_tin_nguoi_phan_anh,
                              child: Container(
                                color: backgroundColorApp,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                child: NguoiPhanAnhTablet(
                                  indexCheck: cubit.checkIndex,
                                  listRow: data?.thongTinPhanAnhRow ?? [],
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
                                    const SizedBox(
                                      height: 20,
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
                                    const SizedBox(
                                      height: 20,
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
                },
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 14.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderButtomColor,
                    ),
                    color: backgroundColorApp,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        YKienXuLyPAKNWidgetExpand(
                          cubit: cubit,
                        ),
                      ],
                    ),
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
