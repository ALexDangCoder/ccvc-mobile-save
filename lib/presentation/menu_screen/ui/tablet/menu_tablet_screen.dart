import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/tablet/manager_personal_information_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/header_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/menu_cell_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/text_button_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_tablet_menu.dart';

class MenuTabletScreen extends StatefulWidget {
  const MenuTabletScreen({Key? key}) : super(key: key);

  @override
  _MenuTabletScreenState createState() => _MenuTabletScreenState();
}

class _MenuTabletScreenState extends State<MenuTabletScreen> {
  MenuCubit menuCubit = MenuCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuCubit.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: menuCubit.stateStream,
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException('', S.current.something_went_wrong),
      child: Scaffold(
        appBar: BaseAppBar(
          title: S.current.menu,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await menuCubit.refeshUser();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagerPersonalInformationTablet(
                          id: menuCubit.id,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 170,
                    child: HeaderMenuWidget(
                      paddingVertical: 20,
                      urlBackGround: headerMenu(),
                      menuCubit: menuCubit,
                      overlayColor: APP_BACKGROUND == null
                          ? Colors.transparent
                          : Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextQuanLyWidget(),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 28,
                  mainAxisSpacing: 28,
                  childAspectRatio: 1.25,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(listFeature.length, (index) {
                    final type = listFeature[index];
                    return containerType(type, () {
                      Navigator.of(context, rootNavigator: true).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => type.getScreen(),
                        ),
                      );
                    });
                  }),
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().backGroundColor(),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: colorBlack.withOpacity(0.05),
                      )
                    ],
                    border: Border.all(color: borderColor.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: lineColor),
                          ),
                        ),
                        child: Text(
                          S.current.cai_dat,
                          style: textNormalCustom(
                            color:  AppTheme.getInstance().colorField(),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Column(
                        children:
                            List.generate(listFeatureAccount.length, (index) {
                          final type = listFeatureAccount[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => type.getScreen(),
                                ),
                              );
                            },
                            child: MenuCellWidget(
                              title: type.getItem().title,
                              urlIcon: type.getItem().url,
                              isBorder: index != listFeatureAccount.length - 1,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: SizedBox(
                        width: 130,
                        child: ButtonBottom(
                          text: S.current.dang_xuat,
                          onPressed: () {
                            showDiaLog(
                              context,
                              funcBtnRight: () {
                                AppStateCt.of(context).appState.setToken('');
                                HiveLocal.clearData();
                                Navigator.pop(context);
                              },
                              showTablet: true,
                              icon: Image.asset(ImageAssets.icDangXuat),
                              title: S.current.dang_xuat,
                              textContent: S.current.ban_co_muon_dang_xuat,
                              btnLeftTxt: S.current.khong,
                              btnRightTxt: S.current.dong_y,
                            );

                          },
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget containerType(MenuType type, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: backgroundColorApp,
          border: Border.all(color: borderColor.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: shadowContainerColor.withOpacity(0.05),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              type.getItem().url,
              width: 20.sp,
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                type.getItem().title,
                style: textNormalCustom(fontSize: 18, color: titleColor),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
