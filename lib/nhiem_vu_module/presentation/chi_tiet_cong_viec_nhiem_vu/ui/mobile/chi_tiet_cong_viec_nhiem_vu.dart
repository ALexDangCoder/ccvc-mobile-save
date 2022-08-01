import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/bloc/chi_tiet_cong_viec_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/widget/lich_su_giao_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/widget/lich_su_thay_doi_trang_thai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/widget/widget_thong_tin_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChitietCongViecNhiemVuMobile extends StatefulWidget {
  final String id;

  const ChitietCongViecNhiemVuMobile({Key? key, required this.id})
      : super(key: key);

  @override
  _ChitietCongViecNhiemVuMobileState createState() =>
      _ChitietCongViecNhiemVuMobileState();
}

class _ChitietCongViecNhiemVuMobileState
    extends State<ChitietCongViecNhiemVuMobile>
    with SingleTickerProviderStateMixin {
  ChiTietCongViecNhiemVuCubit cubit = ChiTietCongViecNhiemVuCubit();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    cubit.callApi(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.chi_tiet_cong_viec),
      body: RefreshIndicator(
        onRefresh: () async {
          cubit.callApi(widget.id);
        },
        child: ProviderWidget<ChiTietCongViecNhiemVuCubit>(
          cubit: cubit,
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {
              cubit.callApi(widget.id);
            },
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: cubit.stateStream,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: radioUnfocusColor,
                      ),
                    ),
                  ),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: S.current.thong_tin_chung,
                      ),
                      Tab(
                        text: S.current.lich_su_giao_viec,
                      ),
                      Tab(
                        text: S.current.lich_su_thay_doi_trang_thai,
                      ),
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                    labelColor: textDefault,
                    unselectedLabelColor: infoColor,
                    indicatorColor: textDefault,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        child: StreamBuilder<ChiTietCongViecNhiemVuModel>(
                          stream: cubit.chiTietCongViecSubject,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            return WidgetThongTinCongViecNhiemVu(
                              cubit: cubit,
                              data: data ?? ChiTietCongViecNhiemVuModel(),
                            );
                          },
                        ),
                      ),
                      StreamBuilder<List<DanhSachCongViecChiTietNhiemVuModel>>(
                        stream: cubit.lichSuGiaoViecStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return LichSuGiaoViecWidget(
                            dataModel: data,
                            cubit: cubit,
                            id: widget.id,
                          );
                        },
                      ),
                      StreamBuilder<List<DanhSachCongViecChiTietNhiemVuModel>>(
                        stream: cubit.lichSuTDTTStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return LichSuTrangThaiWidget(
                            dataModel: data,
                            cubit: cubit,
                            id: widget.id,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
