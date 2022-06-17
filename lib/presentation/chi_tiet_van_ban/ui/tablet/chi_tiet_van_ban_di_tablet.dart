import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/tep_dinh_kem_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_don_vi_nhan_va_nguoi_deo_doi_van_ban_mobie.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_cap_nhat_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_huy_duyet_widget_expand.dart';import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_thu_hoi_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_lich_su_tra_lai_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_theo_doi_van_ban_ban_hanh_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_thong_tin_ky_duyet_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/vb_di_y_kien_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_di_mobile/widget_head_chi_tiet_van_ban_di_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDiTablet extends StatefulWidget {
  final String id;

  const ChiTietVanBanDiTablet({Key? key, required this.id}) : super(key: key);

  @override
  _ChiTietVanBanDiTabletState createState() => _ChiTietVanBanDiTabletState();
}

class _ChiTietVanBanDiTabletState extends State<ChiTietVanBanDiTablet> {
  late CommonDetailDocumentGoCubit commonDetailDocumentGoCubit;

  @override
  void initState() {
    commonDetailDocumentGoCubit = CommonDetailDocumentGoCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban_di),
      body: DefaultTabController(
        length: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorA2AEBD,
                  ),
                ),
              ),
              child: TabBar(
                tabs: [
                  Tab(text: S.current.thong_tin_chung),
                  Tab(text: S.current.don_vi_nhan_va_theo_doi_van_ban),
                  Tab(text: S.current.tep_dinh_kem),
                  Tab(text: S.current.thong_tin_ky_duyet),
                  Tab(text: S.current.y_kien_xu_ly),
                  Tab(text: S.current.lich_su_cap_nhat),
                  Tab(text: S.current.lich_su_tra_lai),
                  Tab(text: S.current.lich_su_thu_hoi),
                  Tab(text: S.current.lich_su_huy_duyet),
                  Tab(text: S.current.theo_doi_van_ban_da_ban_hanh),
                ],
                isScrollable: true,
                unselectedLabelColor: AppTheme.getInstance().unselectColor(),
                labelColor: AppTheme.getInstance().colorField(),
                indicatorColor: AppTheme.getInstance().colorField(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  WidgetHeadChiTietVanBanDiTablet(
                    cubit: commonDetailDocumentGoCubit,
                    id: widget.id,
                  ),
                  TheoDoiVanBanMobile(
                    isTablet: true,
                    cubit: commonDetailDocumentGoCubit,
                    id: widget.id,
                  ),
                  TepDinhKemMobile(
                    isTablet: true,
                    cubit: commonDetailDocumentGoCubit,
                    idDocument: widget.id,
                  ),
                  VBDiThongTinKyDuyetExpandWidgetMobile(
                    isTablet: true,
                    cubit: commonDetailDocumentGoCubit,
                    idDocument: widget.id,
                  ),
                  VBDiYKienXuLyExpandWidget(
                    isTablet: true,
                    cubit: CommentDetailDocumentGoCubit(),
                    idDocument: widget.id,
                  ),
                  VBDiLichSuCapNhatExpandWidget(
                    isTablet: true,
                    cubit: HistoryUpdateDetailDocumentGoCubit(),
                    idDocument: widget.id,
                  ),
                  VBDiLichSuTraLaiExpandWidget(
                    isTablet: true,
                    cubit: HistoryGiveBackDetailDocumentGoCubit(),
                    id: widget.id,
                  ),
                  VBDiLichSuThuHoiExpandWidget(
                    isTablet: true,
                    cubit: HistoryRecallDetailDocumentGoCubit(),
                    id: widget.id,
                  ),
                  VBDiLichSuHuyDuyetExpandWidget(
                    isTablet: true,
                    cubit: UnsubscribeDetailDocumentGoCubit(),
                    id: widget.id,
                  ),
                  VBDiTheoDoiVanBanBanHanhExpandWidget(
                    isTablet: true,
                    cubit: TrackTextDetailDocumentCubit(),
                    id: widget.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
