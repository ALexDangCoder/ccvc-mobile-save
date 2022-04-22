
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/ui/mobile/widgets/widget_expand_yknd_mobile/y_kien_xu_ly_pakn_widget_expand.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/ui/widget/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/ui/widget/thong_tin_nguoi_phan_anh.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/ui/widget/tien_trinh_xu_Ly.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/widgets/explan_group/expanded_only_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showBottomSheetCustom(
      //         context,
      //         title: '',
      //         child: BottomSheetSearchYKND(),
      //     );
      //   },
      // ),
      appBar: AppBarDefaultBack(
        S.current.chi_tiet_yknd,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: cubit.stateStream,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                StreamBuilder<List<DataRowChiTietKienNghi>>(
                  stream: cubit.headerRowData,
                  builder: (context,snapshot){
                    final dataHeader=snapshot.data??[];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChiTietYKNDHeader(
                        listRow: dataHeader,
                      ),);
                  },
                ),
                StreamBuilder<ChiTietYKienNguoiDanRow>(
                  stream: cubit.rowDataChiTietYKienNguoiDan,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    return Column(
                      children: [
                        ExpandOnlyWidget(
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
                        ExpandOnlyWidget(
                          name: S.current.ket_qua_xu_ly,
                          child: Column(
                            children: [
                              KetQuaXuLyScreen(
                                cubit: cubit,
                              ),
                            ],
                          ),
                        ),
                        ExpandOnlyWidget(
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
                          cubit:cubit ,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
