import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_tra_lai_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyVBDi/xem_luong_xu_ly_vb_di_screen.dart';
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
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/widget_head_chi_tiet_van_ban_di_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/xem_luong.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDiTablet extends StatefulWidget {
  final String id;

  const ChiTietVanBanDiTablet({Key? key, required this.id}) : super(key: key);

  @override
  _ChiTietVanBanDiTabletState createState() => _ChiTietVanBanDiTabletState();
}

class _ChiTietVanBanDiTabletState extends State<ChiTietVanBanDiTablet> {
  DetailDocumentCubit cubit = DetailDocumentCubit();

  @override
  void initState() {
    cubit.loadDataVanBanDi(taskId: widget.id, processId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban),
      body: RefreshIndicator(
        onRefresh: () async {
          await cubit.loadDataVanBanDi(taskId: widget.id, processId: widget.id);
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
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 28.0, right: 28.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: borderButtomColor,
                                  ),
                                  color: backgroundColorApp,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                    top: 10.0,
                                    left: 4,
                                    right: 4,
                                  ),
                                  child: WidgetHeadChiTietVanBanDiTablet(
                                      cubit: cubit),
                                )),
                            const SizedBox(
                              height: 28.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderButtomColor,
                                ),
                                color: backgroundColorApp,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child:
                                        StreamBuilder<List<NguoiKyDuyetModel>>(
                                            stream: cubit
                                                .nguoiKyDuyetVanBanDiSubject
                                                .stream,
                                            builder: (context, snapshot) {
                                              final data = snapshot.data ?? [];
                                              return VBDiThongTinKyDuyetExpandWidgetMobile(
                                                cubit: cubit,
                                                nguoiKyDuyetModel: data,
                                              );
                                            }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TepDinhKemMobile(cubit: cubit),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: StreamBuilder<
                                            List<LichSuCapNhatVanBanDi>>(
                                        stream: cubit
                                            .lichSuCapNhatVanBanDiSubject
                                            .stream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? [];
                                          return VBDiLichSuCapNhatExpandWidget(
                                            cubit: cubit,
                                            lichSuCapNhatModel: data,
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: StreamBuilder<
                                            List<LichSuTraLaiVanBanDi>>(
                                        stream: cubit
                                            .lichSuTraLaiVanBanDiSubject.stream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? [];
                                          return VBDiLichSuTraLaiExpandWidget(
                                            cubit: cubit,
                                            lichSuTraLaiModel: data,
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: StreamBuilder<
                                            List<LichSuThuHoiVanBanDi>>(
                                        stream: cubit
                                            .lichSuThuHoiVanBanDiSubject.stream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? [];
                                          return VBDiLichSuThuHoiExpandWidget(
                                            cubit: cubit,
                                            lichSuThuHoiModel: data,
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: StreamBuilder<
                                            List<LichSuHuyDuyetVanBanDi>>(
                                        stream:
                                            cubit.lichSuHuyDuyetVanBanDiSubject,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? [];
                                          return VBDiLichSuHuyDuyetExpandWidget(
                                            cubit: cubit,
                                            lichSuHuyDuyetModel: data,
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: StreamBuilder<
                                            List<LichSuKyDuyetVanBanDi>>(
                                        stream:
                                            cubit.lichSuKyDuyetVanBanDiSubject,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? [];
                                          return VBDiLichSuKyDuyetExpandWidget(
                                            cubit: cubit,
                                            lichSuKyDuyetModel: data,
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: VBDiTheoDoiVanBanBanHanhExpandWidget(
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
                  // const SizedBox(width: 30.0,),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: borderButtomColor,
                                ),
                                color: backgroundColorApp,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: VBDiYKienXuLyExpandWidget(
                                cubit: cubit,
                              ),
                            ),
                            const SizedBox(
                              height: 28.0,
                            ),
                            SizedBox(
                              width: 160,
                              child: ButtonCustomBottom(
                                title: S.current.xem_luong,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => XemLuongXuLyVbDi(
                                        id: widget.id,
                                      ),
                                    ),
                                  );
                                },
                                isColorBlue: true,
                              ),
                            ),
                            const SizedBox(
                              height: 28.0,
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
        ),
      ),
    );
  }
}
