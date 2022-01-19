import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/tablet/manager_personal_information_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/header_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/menu_cell_widget.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/widgets/text_button_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.menu,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ManagerPersonalInformationTablet(),
                  ),
                );
              },
              child: HeaderMenuWidget(
                paddingVertical: 20,
                urlBackGround: ImageAssets.imgHeaderMenuTablet,
                menuCubit: menuCubit,
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
                  Navigator.push(
                    context,
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
                        color: labelColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
          ],
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
