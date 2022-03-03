import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_cap_nhat_tinh_hinh_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_thu_hoi_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_tra_lai_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_van_ban_lien_thong_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/thong_tin_gui_nhan_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/widget_head_chi_tiet_van_ban_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/y_kien_xu_ly_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/xem_luong.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanTablet extends StatefulWidget {
  const ChiTietVanBanTablet({Key? key}) : super(key: key);

  @override
  _ChiTietVanBanTabletState createState() => _ChiTietVanBanTabletState();
}

class _ChiTietVanBanTabletState extends State<ChiTietVanBanTablet> {
  DetailDocumentCubit cubit = DetailDocumentCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chi_tiet_van_ban),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 28.0, right: 28.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: Column(
                        children: [
                          WidgetHeadChiTietVanBanTablet(
                            cubit: cubit,
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: borderButtomColor,
                              ),
                              color: backgroundColorApp,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ThongTinGuiNhanWidgetExpandTablet(
                                    cubit: cubit,
                                    expanded: cubit.expanded,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child:
                                      LichSuCapNhatTinhHinhWidgetExpandTablet(
                                    cubit: cubit,
                                    expanded: cubit.expanded2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: LichSuTraLaiWidgetExpandTablet(
                                    cubit: cubit,
                                    expanded: cubit.expanded3,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: LichSuThuHoiWidgetExpandTablet(
                                    cubit: cubit,
                                    expanded: cubit.expanded4,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child:
                                      LichSuVanBanLienThongWidgetExpandTablet(
                                    cubit: cubit,
                                    expanded: cubit.expanded5,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(width: 30.0,),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          YKienSuLyWidgetExpandTablet(
                            cubit: cubit,
                            expanded: cubit.expanded6,
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          SizedBox(
                            width: 160,
                            child: ButtonCustomBottom(
                              title: S.current.xem_luong,
                              onPressed: () {
                                MaterialPageRoute(
                                  builder: (context) => StreamProcessScreen(),
                                );
                              },
                              isColorBlue: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
