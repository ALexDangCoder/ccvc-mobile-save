import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/header_chi_tiet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_don_doc.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/van_ban_lien_quan_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/y_kien_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChiTietNhiemVuTabletScreen extends StatefulWidget {
  final String id;
  final bool isCheck;
  final String? donViId;

  const ChiTietNhiemVuTabletScreen({
    Key? key,
    required this.id,
    required this.isCheck,
    this.donViId,
  }) : super(key: key);

  @override
  _ChiTietNhiemVuTabletScreenState createState() =>
      _ChiTietNhiemVuTabletScreenState();
}

class _ChiTietNhiemVuTabletScreenState extends State<ChiTietNhiemVuTabletScreen>
    with SingleTickerProviderStateMixin {
  ChiTietNVCubit cubit = ChiTietNVCubit();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    cubit.donViId = widget.donViId;
    cubit.loadDataNhiemVuCaNhan(
      nhiemVuId: widget.id,
      isCheck: widget.isCheck,
    );
    _tabController = TabController(length: 9, vsync: this);
    cubit.idNhiemVu = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWidgets,
      appBar: AppBarDefaultBack(S.current.chi_tiet_nhiem_vu),
      body: ProviderWidget<ChiTietNVCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {
            cubit.loadDataNhiemVuCaNhan(
              nhiemVuId: widget.id,
              isCheck: widget.isCheck,
            );
          },
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: S.current.thong_tin_chung,
                  ),
                  Tab(
                    text: S.current.y_kien_xu_ly,
                  ),
                  Tab(
                    text: S.current.van_ban_lien_quan,
                  ),
                  Tab(
                    text: S.current.danh_sach_cong_viec,
                  ),
                  Tab(
                    text: S.current.lich_su_phan_xu_ly,
                  ),
                  Tab(
                    text: S.current.lich_su_cap_nhat_thth,
                  ),
                  Tab(
                    text: S.current.lich_su_tra_lai,
                  ),
                  Tab(
                    text: S.current.lich_su_thu_hoi,
                  ),
                  Tab(
                    text: S.current.lich_su_don_doc,
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                labelColor: AppTheme.getInstance().colorField(),
                unselectedLabelColor: infoColor,
                indicatorColor: AppTheme.getInstance().colorField(),
                labelStyle: TextStyle(
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w700,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    StreamBuilder<ChiTietNhiemVuModel>(
                      stream: cubit.chiTietHeaderStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? ChiTietNhiemVuModel();
                        return HeaderChiTiet(
                          row: data.toListRow(),
                        );
                      },
                    ),
                    YKienNhiemVuWidget(
                      cubit: cubit,
                    ),
                    VanBanLienQuanWidget(
                      cubit: cubit,
                    ),
                    StreamBuilder<List<DanhSachCongViecChiTietNhiemVuModel>>(
                      stream: cubit.danhSachCongViecStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return DanhSachCongViecWidget(
                          dataModel: data,
                          cubit: cubit,
                        );
                      },
                    ),
                    StreamBuilder<List<LichSuPhanXuLyNhiemVuModel>>(
                      stream: cubit.lichSuPhanXuLySubject,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return LichSuPhanXuLyWidget(
                          dataModel: data,
                          cubit: cubit,
                          idNhiemVu: widget.id,
                        );
                      },
                    ),
                    StreamBuilder<List<LichSuCapNhatTHTHModel>>(
                      stream: cubit.lichSuCapNhatTHTHModelStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return LichSuCapNhatTHTHWidget(
                          dataModel: data,
                          cubit: cubit,
                        );
                      },
                    ),
                    StreamBuilder<List<LichSuTraLaiNhiemVuModel>>(
                      stream: cubit.lichSuTraLaiStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return LichSuTraLaiWidget(
                          dataModel: data,
                          cubit: cubit,
                        );
                      },
                    ),
                    StreamBuilder<List<LichSuThuHoiNhiemVuModel>>(
                      stream: cubit.lichSuThuHoiStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return LichSuThuHoiWidget(
                          dataModel: data,
                          cubit: cubit,
                        );
                      },
                    ),
                    StreamBuilder<List<LichSuDonDocNhiemVuModel>>(
                      stream: cubit.lichSuDonDocStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return LichSuDonDocWidget(
                          dataModel: data,
                          cubit: cubit,
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
    );
  }
}
