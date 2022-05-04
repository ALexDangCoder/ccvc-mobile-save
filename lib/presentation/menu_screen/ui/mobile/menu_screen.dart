
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/manager_personal_information.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/widgets/header_menu_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/header_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/menu_cell_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/text_button_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

import 'icon.dart';
import 'widgets/button_quan_ly_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
        backgroundColor: homeColor,
        appBar: BaseAppBar(
          title: S.current.menu,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await menuCubit.refeshUser();
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
                              builder: (context) => ManagerPersonalInformation(
                                id: menuCubit.id,
                              ),
                            ),
                          );
                        },
                        child: HeaderMenuMobileWidget(
                          menuCubit: menuCubit,
                        ),
                      ),
                     const  ButtonQuanLyMobileWidget(),
                      StreamBuilder<List<MenuType>>(
                        stream: menuCubit.getMenu,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? <MenuType>[];
                          return Column(
                            children: List.generate(data.length, (index) {
                              final type = data[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => type.getScreen(),
                                    ),
                                  );
                                },
                                child: MenuCellWidget(
                                  title: type.getItem().title,
                                  urlIcon: type.getItem().url,
                                ),
                              );
                            }),
                          );
                        }
                      ),
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
                              Navigator.push(
                                context,
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
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonCustomBottom(
                        title: S.current.dang_xuat,
                        onPressed: () {
                          AppStateCt.of(context).appState.setToken('');
                          HiveLocal.clearData();
                        },
                        isColorBlue: false,
                      ),
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
    );
  }
}
