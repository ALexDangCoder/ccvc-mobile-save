import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/chi_tiet_ho_tro/ui/mobile/chi_tiet_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/search_extention.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/ho_tro_ky_thuat_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/them_htkt/mobile/them_moi_yc_ho_tro_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/tim_kiem/mobile/tim_kiem_yc_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/mobile/base_app_bar_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachSuCoMobile extends StatefulWidget {
  const DanhSachSuCoMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final HoTroKyThuatCubit cubit;

  @override
  State<DanhSachSuCoMobile> createState() => _DanhSachSuCoMobileState();
}

class _DanhSachSuCoMobileState extends State<DanhSachSuCoMobile> {
  @override
  void initState() {
    widget.cubit.loadMoreListStream.listen((event) {
      widget.cubit.initListCheckPopup(widget.cubit.loadMoreList.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarMobile(),
      floatingActionButton: floatingHTKTMobile(
        context,
        widget.cubit,
      ),
      body: ListViewLoadMore(
        cubit: widget.cubit,
        isListView: true,
        callApi: (page) => widget.cubit.getListHoTroKyThuat(
          page: page,
        ),
        viewItem: (value, index) => ItemDanhSachSuCo(
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
                  builder: (context) => ChiTietHoTroMobile(
                    idHoTro: value.id,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  BaseAppBarMobile _appBarMobile() => BaseAppBarMobile(
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => TimKiemYcHoTro(
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
                screen: HoTroKyThuatMenuMobile(
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

Widget floatingHTKTMobile(
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
        builder: (context) => ThemMoiYCHoTroMobile(
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
