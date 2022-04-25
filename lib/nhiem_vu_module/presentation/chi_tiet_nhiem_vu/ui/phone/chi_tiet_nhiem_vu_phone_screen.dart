import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
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

class ChiTietNhiemVuPhoneScreen extends StatefulWidget {
  final String id;
  final bool isCheck;

  const ChiTietNhiemVuPhoneScreen({
    Key? key,
    required this.id,
    required this.isCheck,
  }) : super(key: key);

  @override
  _ChiTietNhiemVuPhoneScreenState createState() =>
      _ChiTietNhiemVuPhoneScreenState();
}

class _ChiTietNhiemVuPhoneScreenState extends State<ChiTietNhiemVuPhoneScreen> {
  ChiTietNVCubit cubit = ChiTietNVCubit();

  @override
  void initState() {
    super.initState();
    cubit.loadDataNhiemVuCaNhan(nhiemVuId: widget.id, isCheck: widget.isCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefaultBack(S.current.chi_tiet_nhiem_vu),
      body: RefreshIndicator(
        onRefresh: () async {
          await cubit.loadDataNhiemVuCaNhan(
              nhiemVuId: widget.id, isCheck: widget.isCheck);
        },
        child: ProviderWidget<ChiTietNVCubit>(
          cubit: cubit,
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: cubit.stateStream,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<ChiTietNhiemVuModel>(
                    stream: cubit.chiTietHeaderStream,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? ChiTietNhiemVuModel();
                      return HeaderChiTiet(
                        row: data.toListRow(),
                      );
                    },
                  ),
                  VanBanLienQuanWidget(
                    cubit: cubit,
                  ),
                  StreamBuilder<List<DanhSachCongViecChiTietNhiemVuModel>>(
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
                    stream: cubit.lichSuPhanXuLySubject,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return LichSuPhanXuLyWidget(
                        dataModel: data,
                        cubit: cubit,
                      );
                    },
                  ),
                  YKienNhiemVuWidget(
                    cubit: cubit,
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
                  StreamBuilder<List<LichSuTraLaiNhiemVuModel>>(
                    stream: cubit.lichSuTraLaiStream,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return LichSuTraLaiWidget(
                        dataModel: data,
                        cubit: cubit,
                      );
                    },
                  ),
                  StreamBuilder<List<LichSuThuHoiNhiemVuModel>>(
                    stream: cubit.lichSuThuHoiStream,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return LichSuThuHoiWidget(
                        dataModel: data,
                        cubit: cubit,
                      );
                    },
                  ),
                  StreamBuilder<List<LichSuDonDocNhiemVuModel>>(
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
            ),
          ),
        ),
      ),
    );
  }
}
