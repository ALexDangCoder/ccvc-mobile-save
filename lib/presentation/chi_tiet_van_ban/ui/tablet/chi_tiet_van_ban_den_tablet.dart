import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_cap_nhat_tinh_hinh_xu_ly_widget_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_thu_hoi_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_tra_lai_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/lich_su_van_ban_lien_thong_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/thong_tin_gui_nhan_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_tablet/y_kien_xu_ly_widget_expand_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_expand_van_ban_den_tablet/widget_head_chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/xem_luong.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChiTietVanBanDenTablet extends StatefulWidget {
  final String processId;
  final String taskId;

  const ChiTietVanBanDenTablet({
    Key? key,
    required this.processId,
    required this.taskId,
  }) : super(key: key);

  @override
  _ChiTietVanBanDenTabletState createState() => _ChiTietVanBanDenTabletState();
}

class _ChiTietVanBanDenTabletState extends State<ChiTietVanBanDenTablet> {
  DetailDocumentCubit cubit = DetailDocumentCubit();

  @override
  void initState() {
    cubit.loadDataVanBanDen(taskId: widget.taskId, processId: widget.processId);
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
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 28.0, right: 28.0),
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
                                WidgetHeadChiTietVanBanDenTablet(
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
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: StreamBuilder<
                                                List<ThongTinGuiNhanModel>>(
                                            stream: cubit.thongTinGuiNhanStream,
                                            builder: (context, snapshot) {
                                              final data = snapshot.data ?? [];
                                              return ThongTinGuiNhanWidgetExpandTablet(
                                                thongTinGuiNhanModel: data,
                                                cubit: cubit,
                                                expanded: cubit.expanded,
                                              );
                                            }),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: StreamBuilder<
                                                List<LichSuVanBanModel>>(
                                            stream:
                                                cubit.lichSuCapNhatXuLyStream,
                                            builder: (context, snapshot) {
                                              final data = snapshot.data ?? [];
                                              return LichSuCapNhatTinhHinhWidgetExpandTablet(
                                                lichSuVanBanCapNhatModel: data,
                                                cubit: cubit,
                                                expanded: cubit.expanded2,
                                              );
                                            }),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: LichSuTraLaiWidgetExpandTablet(
                                          cubit: cubit,
                                          expanded: cubit.expanded3,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: LichSuThuHoiWidgetExpandTablet(
                                          cubit: cubit,
                                          expanded: cubit.expanded4,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
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
                                        builder: (context) =>
                                            StreamProcessScreen(),
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
          ),
        ),
      ),
    );
  }
}
