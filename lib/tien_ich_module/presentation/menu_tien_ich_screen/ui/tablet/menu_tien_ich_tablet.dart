import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/menu_tien_ich_screen/ui/menu_item_tien_ich.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MenuTienIchTablet extends StatefulWidget {
  const MenuTienIchTablet({Key? key}) : super(key: key);

  @override
  _MenuTienIchTabletState createState() => _MenuTienIchTabletState();
}

class _MenuTienIchTabletState extends State<MenuTienIchTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.tien_ich),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImageAssets.imageTienIchTablet),
                  ),
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 28,
                mainAxisSpacing: 28,
                childAspectRatio: 1.25,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: List.generate(listFeatureTienIch.length, (index) {
                  final type = listFeatureTienIch[index];
                  return itemMenuTienIchTablet(type, () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => type.getScreenTienIch(),
                      ),
                    );
                  });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget itemMenuTienIchTablet(MenuTypeTienIch type, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 7),
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
            type.getItemTienIch().url,
            width: 25.sp,
            height: 25.sp,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              type.getItemTienIch().title,
              style: textNormalCustom(fontSize: 18, color: titleColor),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}
