import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/lich_su_cap_nhat_tinh_hinh_xu_ly_widget_expand_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/lich_su_thu_hoi_widget_expand_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/lich_su_tra_lai_widget_expand_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/lich_su_van_ban_lien_thong_widget_expand_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/thong_tin_gui_nhan_widget_expand_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/widget_head_chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/y_kien_su_ly_widget_expand_mobile.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDenMobile extends StatelessWidget {
  final String processId;
  final String taskId;
  final DetailDocumentCubit cubit;

  const ChiTietVanBanDenMobile({
    Key? key,
    required this.processId,
    required this.taskId,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  WidgetHeadChiTietVanBanDenMobile(
                    cubit: cubit,
                    processId: processId,
                    taskId: taskId,
                  ),
                  ThongTinGuiNhanExpandWidgetMobile(
                    cubit: cubit,
                    processId: processId,
                  ),
                  YKienXuLyExpandWidgetMobile(
                    cubit: cubit,
                    processId: processId,
                  ),
                  LichSuCapNhatTinhHinhXuLyExpandWidgetMobile(
                    cubit: cubit,
                    processId: processId,
                  ),
                  LichSuTraLaiExpandWidgetMobile(
                    cubit: cubit,
                    processId: processId,
                  ),
                  LichSuThuHoiExpandWidgetMobile(
                    cubit: cubit,
                    processId: processId,
                  ),
                  LichSuVanBanLienThongExpandWidgetMobile(
                    cubit: cubit,
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
