import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/tab_ket_qua_xu_ly_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/tab_thong_tin_nguoi_phan_anh_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/tab_thong_tin_pakn_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/tab_thong_tin_xu_ly_pakn_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/tab_tien_trinh_xy_ly_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/tab_y_kien_xu_ly_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietPKANTablet extends StatefulWidget {
  const ChiTietPKANTablet({
    Key? key,
    required this.iD,
    required this.taskID,
  }) : super(key: key);
  final String iD;
  final String taskID;

  @override
  State<ChiTietPKANTablet> createState() => _ChiTietPKANTabletState();
}

class _ChiTietPKANTabletState extends State<ChiTietPKANTablet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ChiTietPaknCubit cubit;
  int initIndexTab = 0;

  @override
  void initState() {
    super.initState();
    cubit = ChiTietPaknCubit();
    _tabController =
        TabController(length: 6, vsync: this, initialIndex: initIndexTab);
    _tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.chi_tiet_pkan,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppTheme.getInstance().colorField(),
            labelColor: AppTheme.getInstance().colorField(),
            labelStyle:
                textNormalCustom(fontWeight: FontWeight.w700, fontSize: 14),
            unselectedLabelColor: dateColor,
            onTap: (index) {},
            tabs: [
              Tab(
                child: Text(
                  S.current.thong_tin_PAKN,
                ),
              ),
              Tab(
                child: Text(
                  S.current.thong_tin_nguoi_phan_anh,
                ),
              ),
              Tab(
                child: Text(
                  S.current.thong_tin_xu_ly_pakn,
                ),
              ),
              Tab(
                child: Text(
                  S.current.ket_qua_xu_ly,
                ),
              ),
              Tab(
                child: Text(
                  S.current.tien_trinh_xu_ly,
                ),
              ),
              Tab(
                child: Text(
                  S.current.y_kien_xu_ly,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                TabThongTinPAKNTablet(
                  cubit: cubit,
                  id: widget.iD,
                  taskId: widget.taskID,
                ),
                TabThongTinNguoiPhanAnhTablet(
                  cubit: cubit,
                  id: widget.iD,
                  taskId: widget.taskID,
                ),
                TabThongTinXuLyPAKNTablet(
                  cubit: cubit,
                  id: widget.iD,
                  taskId: widget.taskID,
                ),
                TabKetQuaXuLyTablet(
                  id: widget.iD,
                  taskId: widget.taskID,
                  cubit: cubit,
                ),
                TabTienTrinhXuLyTablet(
                  cubit: cubit,
                  id: widget.iD,
                ),
                TabYKienXuLyTablet(
                  cubit: cubit,
                  id: widget.iD,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
