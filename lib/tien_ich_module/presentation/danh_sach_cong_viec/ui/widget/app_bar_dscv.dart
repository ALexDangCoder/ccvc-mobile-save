import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/addToDoWidget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_dscv_tien_tich.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/creat_todo_ver2_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBarDSCV({required DanhSachCongViecTienIchCubit cubit, context}) {
  return AppBar(
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
    bottomOpacity: 0.0,
    leadingWidth: 100,
    elevation: isMobile() ? 0 : 0.7,
    shadowColor: bgDropDown,
    automaticallyImplyLeading: false,
    title: StreamBuilder<String>(
      stream: cubit.titleAppBar.stream,
      builder: (context, snapshot) {
        final title = snapshot.data ?? S.current.cong_viec_cua_ban;
        return Text(
          title,
          style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
        );
      },
    ),
    leading: Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: StreamBuilder<String>(
          stream: cubit.statusDSCV.stream,
          builder: (context, snapshotbool) {
            final dataType = snapshotbool.data ?? 0;
            if (dataType == DSCVScreen.NCVM) {
              return MenuSelectWidget(
                listSelect: [
                  CellPopPupMenu(
                    urlImage: ImageAssets.icEditBlue,
                    text: S.current.doi_lai_ten,
                    onTap: () {
                      if (isMobile()) {
                        showBottomSheetCustom(
                          context,
                          title: S.current.doi_lai_ten,
                          child: AddToDoWidgetTienIch(
                            initData: cubit.titleAppBar.value,
                            onTap: (value) {
                              cubit.updateLabelTodoList(value);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      } else {
                        showDiaLogTablet(
                          context,
                          title: S.current.doi_lai_ten,
                          child: AddToDoWidgetTienIch(
                            initData: cubit.titleAppBar.value,
                            onTap: (value) {
                              cubit.updateLabelTodoList(value);
                              Navigator.pop(context);
                            },
                          ),
                          isBottomShow: false,
                          funcBtnOk: () {},
                          maxHeight: 250,
                        );
                      }
                    },
                  ),
                  CellPopPupMenu(
                    urlImage: ImageAssets.ic_delete_do,
                    text: S.current.xoa,
                    onTap: () {
                      showDiaLog(
                        context,
                        funcBtnRight: () {
                          cubit.deleteGroupTodoList();
                        },
                        icon: SvgPicture.asset(
                          ImageAssets.icDeleteLichHop,
                        ),
                        title:
                            S.current.ban_co_chan_chan_muon_xoa_nhom_cong_viec,
                        textContent: '',
                        btnLeftTxt: S.current.huy,
                        btnRightTxt: S.current.xoa,
                      );
                    },
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
      IconButton(
        onPressed: () {
          DrawerSlide.navigatorSlide(
            context: context,
            screen: MenuDSCV(
              cubit: cubit,
            ),
            thenValue: (value) {},
          );
        },
        icon: SvgPicture.asset(ImageAssets.icMenuCalender),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget buttonThemCongViec({
  required DanhSachCongViecTienIchCubit cubit,
  required BuildContext context,
}) =>
    Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: FloatingActionButton(
        elevation: 0.0,
        onPressed: () {
          showBottomSheetCustom(
            context,
            title: S.current.them_cong_viec,
            child: CreatTodoOrUpdateWidget(
              cubit: cubit,
            ),
          );
        },
        backgroundColor: AppTheme.getInstance().colorField(),
        child: SvgPicture.asset(
          ImageAssets.icAddCalenderWhite,
        ),
      ),
    );

Widget searchWidgetDscv({
  required DanhSachCongViecTienIchCubit cubit,
  required Function(String) textSearch,
}) =>
    BaseSearchBar(
      controller: cubit.searchControler,
      hintText: S.current.tim_kiem_nhanh,
      onChange: (value) {
        textSearch(value);
        cubit.waitToDelay(
          actionNeedDelay: () {
            cubit.callAPITheoFilter(textSearch: value);
          },
          timeSecond: 1,
        );
      },
    );
