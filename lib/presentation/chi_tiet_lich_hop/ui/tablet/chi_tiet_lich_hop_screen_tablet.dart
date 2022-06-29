import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/thong_tin_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DetailMeetCalenderTablet extends StatefulWidget {
  final String id;

  const DetailMeetCalenderTablet({Key? key, required this.id})
      : super(key: key);

  @override
  State<DetailMeetCalenderTablet> createState() =>
      _DetailMeetCalenderTabletState();
}

class _DetailMeetCalenderTabletState extends State<DetailMeetCalenderTablet>
    with SingleTickerProviderStateMixin {
  late DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  final ThanhPhanThamGiaCubit cubitThanhPhan = ThanhPhanThamGiaCubit();
  final ThemCanBoCubit themCanBoCubit = ThemCanBoCubit();
  late TabController _controller;
  List<String> listTextTab = [
    S.current.cong_tac_chuan_bi,
    S.current.chuong_trinh_hop,
    S.current.thanh_phan_tham_gia,
    S.current.tai_lieu,
    S.current.phat_bieu,
    S.current.bieu_quyet,
    S.current.ket_luan_hop,
    S.current.y_kien_cuop_hop
  ];

  @override
  void initState() {
    cubit.idCuocHop = widget.id;
    cubitThanhPhan.getTree();
    cubit.initDataChiTiet(needCheckPermission: true);
    cubit.getDanhSachCanBoHop(widget.id);
    _controller = TabController(vsync: this, length: listTextTab.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: appbarChiTietHop(cubit, context, cubitThanhPhan, themCanBoCubit),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16.0, left: 16.0),
        child: DefaultTabController(
          length: listTextTab.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: ExpandGroup(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          border:
                              Border.all(color: borderColor.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 10,
                                color: shadowContainerColor.withOpacity(0.05))
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ThongTinCuocHopWidget(
                                cubit: cubit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
            body: ProviderWidget<DetailMeetCalenderCubit>(
              cubit: cubit,
              child: StateStreamLayout(
                textEmpty: S.current.khong_co_du_lieu,
                retry: () {},
                error: AppException(
                  S.current.error,
                  S.current.error,
                ),
                stream: cubit.stateStream,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: backgroundColorApp,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    border: Border.all(color: borderColor.withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                          color: shadowContainerColor.withOpacity(0.05))
                    ],
                  ),
                  child: StickyHeader(
                    overlapHeaders: true,
                    header: TabBar(
                      controller: _controller,
                      unselectedLabelStyle: textNormalCustom(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      indicatorColor: indicatorColor,
                      unselectedLabelColor: colorA2AEBD,
                      labelColor: indicatorColor,
                      labelStyle: textNormalCustom(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      isScrollable: true,
                      tabs: List.generate(
                        listTextTab.length,
                        (index) => Tab(
                          child: Text(
                            listTextTab[index],
                          ),
                        ),
                      ),
                    ),
                    content: TabBarView(
                      controller: _controller,
                      children: listWidgetChiTietHop(cubit),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
