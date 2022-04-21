import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_tra_lai_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/tep_dinh_kem_widget/tep_dinh_kem_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_cap_nhat_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_huy_duyet_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_ky_duyet_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_thu_hoi_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_tra_lai_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_theo_doi_van_ban_ban_hanh_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_thong_tin_ky_duyet_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_y_kien_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/widget_head_chi_tiet_van_ban_di.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDiMobile extends StatefulWidget {
  final String id;

  ChiTietVanBanDiMobile({Key? key, required this.id}) : super(key: key);

  @override
  _ChiTietVanBanDiMobileState createState() => _ChiTietVanBanDiMobileState();
}

class _ChiTietVanBanDiMobileState extends State<ChiTietVanBanDiMobile> {
  DetailDocumentCubit cubit = DetailDocumentCubit();

  @override
  void initState() {
    cubit.loadDataVanBanDi(processId: widget.id, taskId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban_di),
      body: RefreshIndicator(
        onRefresh: () async {
          await cubit.loadDataVanBanDi(processId: widget.id, taskId: widget.id);
        },
        child: ProviderWidget<DetailDocumentCubit>(
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
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetHeadChiTietVanBanDi(cubit: cubit),
                    StreamBuilder<List<NguoiKyDuyetModel>>(
                        stream: cubit.nguoiKyDuyetVanBanDiSubject.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return VBDiThongTinKyDuyetExpandWidgetMobile(
                            cubit: cubit,
                            nguoiKyDuyetModel: data,
                          );
                        }),
                    TepDinhKemMobile(cubit: cubit),
                    VBDiYKienXuLyExpandWidget(
                      cubit: cubit,
                    ),
                    StreamBuilder<List<LichSuCapNhatVanBanDi>>(
                        stream: cubit.lichSuCapNhatVanBanDiSubject.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return VBDiLichSuCapNhatExpandWidget(
                            cubit: cubit,
                            lichSuCapNhatModel: data,
                          );
                        }),
                    StreamBuilder<List<LichSuTraLaiVanBanDi>>(
                        stream: cubit.lichSuTraLaiVanBanDiSubject.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return VBDiLichSuTraLaiExpandWidget(
                            cubit: cubit,
                            lichSuTraLaiModel: data,
                          );
                        }),
                    StreamBuilder<List<LichSuThuHoiVanBanDi>>(
                        stream: cubit.lichSuThuHoiVanBanDiSubject.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return VBDiLichSuThuHoiExpandWidget(
                            cubit: cubit,
                            lichSuThuHoiModel: data,
                          );
                        }),
                    StreamBuilder<List<LichSuHuyDuyetVanBanDi>>(
                        stream: cubit.lichSuHuyDuyetVanBanDiSubject,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return VBDiLichSuHuyDuyetExpandWidget(
                            cubit: cubit,
                            lichSuHuyDuyetModel: data,
                          );
                        }),
                    StreamBuilder<List<LichSuKyDuyetVanBanDi>>(
                        stream: cubit.lichSuKyDuyetVanBanDiSubject,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return VBDiLichSuKyDuyetExpandWidget(
                            cubit: cubit,
                            lichSuKyDuyetModel: data,
                          );
                        }),
                    VBDiTheoDoiVanBanBanHanhExpandWidget(
                      cubit: cubit,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 24.0, left: 16.0, right: 16.0),
                      child: ButtonCustomBottom(
                        isColorBlue: false,
                        title: S.current.xem_luong,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
