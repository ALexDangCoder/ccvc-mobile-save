import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/tablet/chi_tiet_ho_tro_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/search_extention.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/ho_tro_ky_thuat_menu_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/them_htkt/tablet/them_moi_yc_ho_tro_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/tim_kiem/tablet/tim_kiem_yc_ho_tro_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/extensions/event_bus.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/mobile/base_app_bar_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachSuCoTablet extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const DanhSachSuCoTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<DanhSachSuCoTablet> createState() => _DanhSachSuCoTabletState();
}

class _DanhSachSuCoTabletState extends State<DanhSachSuCoTablet> {
  @override
  void initState() {
    widget.cubit.loadMoreListStream.listen((event) {
      widget.cubit.initListCheckPopup(widget.cubit.loadMoreList.length);
    });
    handleEventBus();
    super.initState();
  }
  void handleEventBus() {
    eventBus.on<RefreshListTrouble>().listen((event) {
      widget.cubit.getListHoTroKyThuat(
        page: ApiConstants.PAGE_BEGIN,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1024, 1366),
        builder: () {
          return Scaffold(
            appBar: _appBarTablet(),
            backgroundColor: bgColor,
            floatingActionButton: floatingHTKTTablet(
              context,
              widget.cubit,
            ),
            body: ListViewLoadMore(
              physics: const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              cubit: widget.cubit,
              isListView: true,
              callApi: (page) => widget.cubit.getListHoTroKyThuat(
                page: page,
              ),
              emptyView: const NodataWidget(),
              viewItem: (value, index) => Container(
                margin: EdgeInsets.only(
                  top: index == 0 ? 14 : 0,
                ),
                child: ItemDanhSachSuCo(
                  isTablet: true,
                  flexTitle: 2,
                  flexBody: 9,
                  cubit: widget.cubit,
                  objDSSC: value,
                  index: index ?? 0,
                  onClickMore: (value, index) {
                    widget.cubit.onClickPopupMenu(
                      value,
                      index,
                    );
                    setState(() {});
                  },
                  onClose: () {
                    if (widget.cubit.listCheckPopupMenu[index ?? 0]) {
                      widget.cubit.onClosePopupMenu();
                      setState(() {});
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChiTietHoTroTablet(
                            idHoTro: value.id,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        });
  }

  BaseAppBarMobile _appBarTablet() => BaseAppBarMobile(
        title: S.current.danh_sach_su_co,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => TimKiemYcHoTroTablet(
                  cubit: widget.cubit,
                ),
              ).whenComplete(() => widget.cubit.onSearchPop());
            },
            child: SvgPicture.asset(
              ImageAssets.ic_search,
            ),
          ),
          spaceW4,
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: HoTroKyThuatMenuTablet(
                  cubit: widget.cubit,
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          ),
        ],
      );
}

Widget floatingHTKTTablet(
  BuildContext context,
  HoTroKyThuatCubit cubit,
) {
  return FloatingActionButton(
    elevation: 0,
    backgroundColor: AppTheme.getInstance().colorField(),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ThemMoiYCHoTroTablet(
          cubit: cubit,
        ),
      );
    },
    child: const Icon(
      Icons.add,
      size: 32,
    ),
  );
}
