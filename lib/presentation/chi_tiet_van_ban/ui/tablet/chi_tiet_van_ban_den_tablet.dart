import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_cap_nhat_tinh_hinh_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_thu_hoi_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_tra_lai_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_van_ban_lien_thong_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/thong_tin_gui_nhan_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/widget_head_chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/y_kien_xu_ly_widget_expand_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDenTablet extends StatelessWidget {
  final String processId;
  final String taskId;

  const ChiTietVanBanDenTablet({
    Key? key,
    required this.processId,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban_den),
      body: DefaultTabController(
        length: 7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const  BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: unselectLabelColor,
                  ),
                ),
              ),
              child: TabBar(
                tabs: [
                  Tab(text: S.current.thong_tin_chung),
                  Tab(text: S.current.thong_tin_gui_nhan),
                  Tab(text: S.current.y_kien_xu_ly),
                  Tab(text: S.current.lich_su_cap_nhat),
                  Tab(text: S.current.lich_su_tra_lai),
                  Tab(text: S.current.lich_su_thu_hoi),
                  Tab(text: S.current.van_ban_lien_quan),
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
                  WidgetHeadChiTietVanBanDenTablet(
                    cubit: CommonDetailDocumentCubit(),
                    processId: processId,
                    taskId: taskId,
                  ),
                  ThongTinGuiNhanWidgetExpandTablet(
                    cubit: DeliveryNoticeDetailDocumentCubit(),
                    processId: processId,
                  ),
                  YKienSuLyWidgetExpandTablet(
                    cubit: CommentsDetailDocumentCubit(),
                    processId: processId,
                  ),
                  LichSuCapNhatTinhHinhWidgetExpandTablet(
                    cubit: HistoryUpdateDetailDocumentCubit(),
                    processId: processId,
                  ),
                  LichSuTraLaiWidgetExpandTablet(
                    cubit: HistoryRecallDetailDocumentCubit(),
                    processId: processId,
                  ),
                  LichSuThuHoiWidgetExpandTablet(
                    cubit: HistoryGiveBackDetailDocumentCubit(),
                    processId: processId,
                  ),
                  LichSuVanBanLienThongWidgetExpandTablet(
                    cubit: RelatedDocumentsDetailDocumentCubit(),
                    processId: processId,
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
