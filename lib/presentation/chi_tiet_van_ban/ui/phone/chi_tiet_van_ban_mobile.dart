import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_cap_nhat_tinh_hinh_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_thu_hoi_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_tra_lai_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/lich_su_van_ban_lien_thong_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/thong_tin_gui_nhan_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/widget_head_chi_tiet_van_ban.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand/y_kien_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanMobile extends StatefulWidget {
  const ChiTietVanBanMobile({Key? key}) : super(key: key);

  @override
  _ChiTietVanBanMobileState createState() => _ChiTietVanBanMobileState();
}

class _ChiTietVanBanMobileState extends State<ChiTietVanBanMobile> {
  DetailDocumentCubit cubit=DetailDocumentCubit();
  @override
  void initState() {
    cubit.getChiTietVanBanDi('3f68dcea-f9d4-462a-b1dd-4d30a6551195');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ExpandGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetHeadChiTietVanBan(cubit: cubit),
              ThongTinGuiNhanExpandWidget(cubit: cubit),
              YKienXuLyExpandWidget(cubit: cubit,),
              LichSuCapNhatTinhHinhXuLyExpandWidget(cubit: cubit),
              LichSuTraLaiExpandWidget(cubit: cubit),
              LichSuThuHoiExpandWidget(cubit: cubit),
              LichSuVanBanLienThongExpandWidget(cubit: cubit),

            ],
          ),

        ),
      ),
    );
  }
}
