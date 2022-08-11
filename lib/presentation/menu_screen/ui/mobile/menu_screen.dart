import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/main.dart';

import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/manager_personal_information.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_state.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/widgets/header_menu_widget.dart';

import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/menu_cell_widget.dart';

import 'package:ccvc_mobile/tien_ich_module/presentation/sua_danh_ba_ca_nhan/widget/input_infor_user_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';

import 'widgets/button_quan_ly_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuCubit menuCubit = MenuCubit();
  String version = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuCubit.getUser();
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        version = 'v${packageInfo.version}#${packageInfo.buildNumber}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
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
          backgroundColor: homeColor,
          appBar: BaseAppBar(
            title: S.current.menu,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await menuCubit.refeshMenu();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: AppTheme.getInstance().backGroundColor(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ManagerPersonalInformation(
                                  id: menuCubit.id,
                                ),
                              ),
                            ).then((value) {
                              if (value is bool && value) {
                                menuCubit.getUserRefresh();
                              }
                            });
                          },
                          child: HeaderMenuMobileWidget(
                            menuCubit: menuCubit,
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: colorECEEF7),
                              ),
                            ),
                            child: const ButtonQuanLyMobileWidget()),
                        StreamBuilder<List<MenuType>>(
                            stream: menuCubit.getMenu,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? <MenuType>[];
                              return Column(
                                children: List.generate(data.length, (index) {
                                  final type = data[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (Platform.isIOS) {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                type.getScreen(),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                type.getScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    child: MenuCellWidget(
                                      title: type.getItem().title,
                                      urlIcon: type.getItem().url,
                                    ),
                                  );
                                }),
                              );
                            }),
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    color: AppTheme.getInstance().backGroundColor(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Column(
                          children:
                              List.generate(listFeatureAccount.length, (index) {
                            final type = listFeatureAccount[index];
                            return GestureDetector(
                              onTap: () {
                                if (type == MenuType.chuyenPhamVi) {
                                  showChuyenPhamVi();
                                } else {
                                  if (Platform.isIOS) {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => type.getScreen(),
                                      ),
                                    );
                                  } else {
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
                                isBorder:
                                    index != listFeatureAccount.length - 1,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonCustomBottom(
                          title: S.current.dang_xuat,
                          onPressed: () {
                            showDiaLog(
                              context,
                              funcBtnRight: () {
                                AppStateCt.of(context).appState.setToken('');
                                menuCubit.logout();
                              },
                              showTablet: false,
                              icon: Image.asset(ImageAssets.icDangXuat),
                              title: S.current.dang_xuat,
                              textContent: S.current.ban_co_muon_dang_xuat,
                              btnLeftTxt: S.current.khong,
                              btnRightTxt: S.current.dong_y,
                            );
                          },
                          isColorBlue: false,
                        ),
                        Text('$version'),
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showChuyenPhamVi() {
    showBottomSheetCustom(context,
        child: Column(
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
              height: 24,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: ButtonCustomBottom(
                  onPressed: () {
                    menuCubit.chuyenPhamVi();
                    Navigator.pop(context);
                  },
                  title: S.current.chuyen_pham_vi,
                  isColorBlue: true,
                ),
              ),
            )
          ],
        ),
        title: S.current.chon_pham_vi);
  }
}
