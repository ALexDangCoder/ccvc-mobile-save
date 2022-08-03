import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/tab_ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/tab_thong_tin_nguoi_phan_anh.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/tab_thong_tin_pakn.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/tab_thong_tin_xu_ly_pakn.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/tab_tien_trinh_xy_ly.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/tab_y_kien_xu_ly.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietPKAN extends StatefulWidget {
  const ChiTietPKAN({
    Key? key,
    required this.iD,
    required this.taskID,
  }) : super(key: key);
  final String iD;
  final String taskID;

  @override
  State<ChiTietPKAN> createState() => _ChiTietPKANState();
}

class _ChiTietPKANState extends State<ChiTietPKAN>
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
                TabThongTinPAKN(
                  cubit: cubit,
                  id: widget.iD,
                  taskId: widget.taskID,
                ),
                TabThongTinNguoiPhanAnh(
                  cubit: cubit,
                  id: widget.iD,
                  taskId: widget.taskID,
                ),
                TabThongTinXuLyPAKN(
                  id: widget.iD,
                  taskId: widget.taskID,
                  cubit: cubit,
                ),
                TabKetQuaXuLy(
                  id: widget.iD,
                  taskId: widget.taskID,
                  cubit: cubit,
                ),
                TabTienTrinhXuLy(
                  cubit: cubit,
                  id: widget.iD,
                ),
                TabYKienXuLy(
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
