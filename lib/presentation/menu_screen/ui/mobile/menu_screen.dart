import 'package:ccvc_mobile/config/resources/color.dart';

import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/header_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/menu_cell_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/text_button_widget.dart';

import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: homeColor,
      appBar: BaseAppBar(
        title: S.current.menu,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: AppTheme.getInstance().backGroundColor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderMenuWidget(
                    menuCubit: menuCubit,
                  ),
                  Column(
                    children: List.generate(listFeature.length, (index) {
                      final type = listFeature[index];
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
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 24),
                    child: TextQuanLyWidget(),
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
                    children: List.generate(listFeatureAccount.length, (index) {
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
                    onPressed: () {},
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
    );
  }
}
