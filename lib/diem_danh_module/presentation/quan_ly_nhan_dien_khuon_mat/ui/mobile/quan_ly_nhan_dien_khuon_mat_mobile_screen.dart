import 'package:ccvc_mobile/bao_cao_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/tab_anh_deo_kinh.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/tab_anh_khong_deo_kinh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuanLyNhanDienKhuonMatMobileScreen extends StatefulWidget {
  final DiemDanhCubit cubit;

  const QuanLyNhanDienKhuonMatMobileScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _QuanLyNhanDienKhuonMatMobileScreenState createState() =>
      _QuanLyNhanDienKhuonMatMobileScreenState();
}

class _QuanLyNhanDienKhuonMatMobileScreenState
    extends State<QuanLyNhanDienKhuonMatMobileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ImagePermission imagePermission;

  @override
  void initState() {
    super.initState();
    imagePermission = ImagePermission();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              DrawerSlide.navigatorSlide(
                context: context,
                screen: DiemDanhMenuMobile(
                  cubit: widget.cubit,
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          )
        ],
      ),
      body: StateStreamLayout(
        stream: widget.cubit.stateStream,
        error: AppException(
          S.current.error,
          S.current.something_went_wrong,
        ),
        retry: () {},
        textEmpty: S.current.khong_co_du_lieu,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: S.current.anh_khong_deo_kinh,
                ),
                Tab(
                  text: S.current.anh_deo_kinh,
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppTheme.getInstance().colorField(),
              unselectedLabelColor: color667793,
              indicatorColor: AppTheme.getInstance().colorField(),
              unselectedLabelStyle: textNormalCustom(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              labelStyle: textNormalCustom(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  TabAnhKhongDeoKinh(
                    imagePermission: imagePermission,
                    cubit: widget.cubit,
                  ),
                  TabAnhDeoKinh(
                    cubit: widget.cubit,
                    imagePermission: imagePermission,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
