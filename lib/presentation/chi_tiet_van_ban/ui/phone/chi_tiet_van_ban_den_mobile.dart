import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_cap_nhat_tinh_hinh_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_thu_hoi_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_tra_lai_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_van_ban_lien_thong_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/thong_tin_gui_nhan_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/y_kien_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_mobile/widget_head_chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDenMobile extends StatefulWidget {
  final String processId;
  final String taskId;

  const ChiTietVanBanDenMobile({
    Key? key,
    required this.processId,
    required this.taskId,
  }) : super(key: key);

  @override
  _ChiTietVanBanDenMobileState createState() => _ChiTietVanBanDenMobileState();
}

class _ChiTietVanBanDenMobileState extends State<ChiTietVanBanDenMobile> {
  DetailDocumentCubit cubit = DetailDocumentCubit();

  @override
  void initState() {
    cubit.loadDataVanBanDen(taskId: widget.taskId, processId: widget.processId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban),
      body: RefreshIndicator(
        onRefresh: () async {
          await cubit.loadDataVanBanDen(
            taskId: widget.taskId,
            processId: widget.processId,
          );
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExpandGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetHeadChiTietVanBanDenMobile(cubit: cubit),
                    ThongTinGuiNhanExpandWidget(cubit: cubit),
                    YKienXuLyExpandWidget(
                      cubit: cubit,
                    ),
                    LichSuCapNhatTinhHinhXuLyExpandWidget(cubit: cubit),
                    LichSuTraLaiExpandWidget(cubit: cubit),
                    LichSuThuHoiExpandWidget(cubit: cubit),
                    LichSuVanBanLienThongExpandWidget(cubit: cubit),
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
