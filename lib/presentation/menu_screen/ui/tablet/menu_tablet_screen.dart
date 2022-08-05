
import 'dart:io';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/tablet/manager_personal_information_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_state.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/widgets/button_quan_ly_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/header_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/menu_cell_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/sua_danh_ba_ca_nhan/widget/input_infor_user_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

import 'icon_tablet_menu.dart';

class MenuTabletScreen extends StatefulWidget {
  final MenuCubit menuCubit;

  const MenuTabletScreen({Key? key, required this.menuCubit}) : super(key: key);

  @override
  _MenuTabletScreenState createState() => _MenuTabletScreenState();
}

class _MenuTabletScreenState extends State<MenuTabletScreen> {
  late MenuCubit menuCubit;
  String version = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuCubit = widget.menuCubit;
    menuCubit.getUser();
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        version = 'v${packageInfo.version}#${packageInfo.buildNumber}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MenuCubit>(
      cubit: menuCubit,
      child: BlocListener(
        bloc: menuCubit,
        listener: (BuildContext context, state) {
          if (state is ChuyenPhamViSucsess) {
            AppStateCt.of(context).appState.refreshTokenFunc(state.token);
          }
        },
        child: StateStreamLayout(
          stream: menuCubit.stateStream,
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('', S.current.something_went_wrong),
          child: Scaffold(
            backgroundColor: bgWidgets,
            appBar: BaseAppBar(
              backGroundColor: bgWidgets,
              title: S.current.menu,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await menuCubit.refeshMenu();
              },
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ManagerPersonalInformationTablet(
                                id: menuCubit.id,
                              ),
                            ),
                          );
                        },
                        child: HeaderMenuWidget(
                          urlBackGround: headerMenu(),
                          menuCubit: menuCubit,
                          overlayColor: APP_BACKGROUND == null
                              ? Colors.transparent
                              : Colors.black.withOpacity(0.2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ButtonQuanLyMobileWidget(),
                            StreamBuilder<UserInformationModel>(
                                stream: keyHomeTablet
                                    .currentState?.homeCubit.getInforUser,
                                builder: (context, snapshot) {
                                  final data = snapshot.data;
                                  return Visibility(
                                    visible: data?.isSinhNhat() ?? false,
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Image.asset(
                                          ImageAssets.icHappyBirthday,
                                          height: 40,
                                        )),
                                  );
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            StreamBuilder<List<MenuType>>(
                                stream: menuCubit.getMenu,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? <MenuType>[];
                                  if (data.isEmpty) {
                                    return const SizedBox();
                                  }
                                  return GridView.count(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    crossAxisSpacing: 28,
                                    mainAxisSpacing: 28,
                                    childAspectRatio: 1.25,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4,
                                    children:
                                        List.generate(data.length, (index) {
                                      final type = data[index];
                                      return containerType(type, () {
                                        if(Platform.isIOS){
                                          Navigator.of(context,
                                              rootNavigator: true)
                                              .push(
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  type.getScreen(),
                                            ),
                                          );
                                        }else {
                                          Navigator.of(context,
                                              rootNavigator: true)
                                              .push(
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  type.getScreen(),
                                            ),
                                          );
                                        }

                                      });
                                    }),
                                  );
                                }),
                            const SizedBox(
                              height: 28,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: AppTheme.getInstance().backGroundColor(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: colorBlack.withOpacity(0.05),
                                  )
                                ],
                                border: Border.all(
                                    color: borderColor.withOpacity(0.5)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: colorECEEF7),
                                      ),
                                    ),
                                    child: Text(
                                      S.current.cai_dat,
                                      style: textNormalCustom(
                                        color:
                                            AppTheme.getInstance().colorField(),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        listFeatureAccount.length, (index) {
                                      final type = listFeatureAccount[index];
                                      return GestureDetector(
                                        onTap: () {
                                          if (type == MenuType.chuyenPhamVi) {
                                            showChuyenPhamVi();
                                          } else {
                                            if(Platform.isIOS){
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      type.getScreen(),
                                                ),
                                              );
                                            }else {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      type.getScreen(),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: MenuCellWidget(
                                          title: type.getItem().title,
                                          urlIcon: type.getItem().url,
                                          isBorder: index !=
                                              listFeatureAccount.length - 1,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
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
                                      AppStateCt.of(context)
                                          .appState
                                          .setToken('');
                                      HiveLocal.clearData();
                                    },
                                    showTablet: true,
                                    icon: Image.asset(ImageAssets.icDangXuat),
                                    title: S.current.dang_xuat,
                                    textContent:
                                        S.current.ban_co_muon_dang_xuat,
                                    btnLeftTxt: S.current.khong,
                                    btnRightTxt: S.current.dong_y,
                                  );
                                },
                              )),
                        ),
                      ),
                      Text('$version'),
                    ],
                  ),
                ),
              ),
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
        padding: const EdgeInsets.all(15),
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
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  type.getItem().title,
                  style: textNormalCustom(fontSize: 18, color: color3D5586),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showChuyenPhamVi() {
    showDiaLogTablet(
      context,
      isBottomShow: false,
      btnLeftTxt: S.current.huy,
      btnRightTxt: S.current.chuyen_pham_vi,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputInfoUserWidget(
            title: S.current.pham_vi,
            child: CoolDropDown(
              placeHoder: S.current.vuiLongChon,
              listData: menuCubit.listPhamVi.map((e) => e.phamVi).toList(),
              initData: menuCubit.selectedPhamVi?.phamVi ?? '',
              onChange: (value) {
                menuCubit.currentPhamVi = menuCubit.listPhamVi[value];
              },
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 142,
                child: ButtonCustomBottom(
                  title: S.current.huy,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isColorBlue: false,
                ),
              ),
              const SizedBox(
                width: 28,
              ),
              SizedBox(
                width: 210,
                child: ButtonCustomBottom(
                  title: S.current.chuyen_pham_vi,
                  onPressed: () {
                    menuCubit.chuyenPhamVi();
                    Navigator.pop(context);
                  },
                  isColorBlue: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 36,
          ),
        ],
      ),
      title: S.current.chon_pham_vi,
      funcBtnOk: () {},
    );
  }
}
