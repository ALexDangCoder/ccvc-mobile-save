import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_tabllet.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/tablet/tab_anh_deo_kinh_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/tablet/tab_anh_khong_deo_kinh_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuanLyNhanDienKhuonMatTabletScreen extends StatefulWidget {
  final DiemDanhCubit cubit;

  const QuanLyNhanDienKhuonMatTabletScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _QuanLyNhanDienKhuonMatTabletScreenState createState() =>
      _QuanLyNhanDienKhuonMatTabletScreenState();
}

class _QuanLyNhanDienKhuonMatTabletScreenState
    extends State<QuanLyNhanDienKhuonMatTabletScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorF9FAFF,
      appBar: BaseAppBar(
        title: S.current.quan_ly_nhan_dien_khuon_mat,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiemDanhMenuTablet(
                    cubit: widget.cubit,
                  ),
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                text: S.current.anh_khong_deo_kinh,
              ),
              Tab(
                text: S.current.anh_deo_kinh,
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppTheme.getInstance().colorField(),
            unselectedLabelColor: color667793,
            indicatorColor: AppTheme.getInstance().colorField(),
            unselectedLabelStyle: textNormalCustom(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: textNormalCustom(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TabAnhKhongDeoKinhTablet(cubit: widget.cubit),
                TabAnhDeoKinhTablet(
                  cubit: widget.cubit,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
