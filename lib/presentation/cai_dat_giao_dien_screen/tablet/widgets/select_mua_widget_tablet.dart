import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/widgets/check_box_widget.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/widgets/title_cai_dat_widget.dart';
import 'package:ccvc_mobile/utils/app_back_ground_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SelectMuaTabletWidget extends StatelessWidget {
  final List<AppBackGround> list;
  final String title;

  const SelectMuaTabletWidget(
      {Key? key, this.list = const [], required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorApp,
      padding: const EdgeInsets.only(top: 28, bottom: 28),
      child: TitleCaiDatWidget(
        title: title,
        bottomPadding: 25,
        child: Container(
          color: Colors.transparent,
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            crossAxisSpacing: 20.w,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              return Padding(
                padding: EdgeInsets.only(top: index <= 3 ? 0 : 30),
                child: selectImageCell(context, data),
              );
            },
            staggeredTileBuilder: (index) {
              return const StaggeredTile.fit(1);
            },
          ),
        ),
      ),
    );
  }

  Widget selectImageCell(BuildContext context, AppBackGround appBackGround) {
    return GestureDetector(
      onTap: () {
        AppStateCt.of(context).appState.setAppBackGround(appBackGround);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage(appBackGround.getIcon()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            FittedBox(
              child: Text(
                appBackGround.getText(),
                style: textNormalCustom(fontSize: 16, color: infoColor),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            CheckBoxWidget(
              value: appBackGround == APP_BACKGROUND,
              onChange: (value) {
                AppStateCt.of(context).appState.setAppBackGround(appBackGround);
              },
            )
          ],
        ),
      ),
    );
  }
}
