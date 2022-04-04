import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/header_chi_tiet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_don_doc.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/van_ban_lien_quan_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/y_kien_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChiTietNhiemVuTabletScreen extends StatefulWidget {
  final String id;

  const ChiTietNhiemVuTabletScreen({Key? key, this.id = ''}) : super(key: key);

  @override
  _ChiTietNhiemVuTabletScreenState createState() =>
      _ChiTietNhiemVuTabletScreenState();
}

class _ChiTietNhiemVuTabletScreenState
    extends State<ChiTietNhiemVuTabletScreen> {
  ChiTietNVCubit cubit = ChiTietNVCubit();

  @override
  void initState() {
    super.initState();
    cubit.initChiTietNV();
    cubit.loadDataNhiemVuCaNhan(nhiemVuId: '04632f86-274c-4e93-a203-7cd92b5dd7fe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWidgets,
      appBar: AppBarDefaultBack(S.current.chi_tiet_nhiem_vu),
      body: ProviderWidget<ChiTietNVCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<ChiTietNhiemVuModel>(
                            stream: cubit.chiTietHeaderStream,
                            builder: (context, snapshot) {
                              final data =
                                  snapshot.data ?? ChiTietNhiemVuModel();
                              return HeaderChiTiet(
                                row: data.toListRow(),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(color: toDayColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<VanBanLienQuanModel>(
                                  stream: cubit.vanBanLienQuanStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ??
                                        VanBanLienQuanModel.empty();
                                    return VanBanLienQuanWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                                StreamBuilder<
                                    List<DanhSachCongViecChiTietNhiemVuModel>>(
                                  stream: cubit.danhSachCongViecStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return DanhSachCongViecWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                                StreamBuilder<List<LichSuPhanXuLyNhiemVuModel>>(
                                  stream: cubit.lichSuPhanXuLyModelStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return LichSuPhanXuLyWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                                StreamBuilder<List<LichSuCapNhatTHTHModel>>(
                                  stream: cubit.lichSuCapNhatTHTHModelStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return LichSuCapNhatTHTHWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                                StreamBuilder<List<LichSuTraLaiModel>>(
                                  stream: cubit.lichSuTraLaiStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return LichSuTraLaiWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                                StreamBuilder<List<LichSuThuHoiModel>>(
                                  stream: cubit.lichSuThuHoiStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return LichSuThuHoiWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                                StreamBuilder<List<LichSuDonDocModel>>(
                                  stream: cubit.lichSuDonDocStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return LichSuDonDocWidget(
                                      dataModel: data,
                                      cubit: cubit,
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(color: toDayColor),
                        ),
                        margin: const EdgeInsets.only(left: 14),
                        child: YKienNhiemVuWidget(
                          cubit: cubit,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
