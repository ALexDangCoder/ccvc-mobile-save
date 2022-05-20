import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/main.dart';
import 'package:ccvc_mobile/presentation/cai_dat_giao_dien_screen/widgets/title_cai_dat_widget.dart';
import 'package:ccvc_mobile/utils/app_back_ground_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectMuaWidget extends StatelessWidget {
  final List<AppBackGround> list;
  final String title;

  const SelectMuaWidget({Key? key, this.list = const [], required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorFFFFFF,
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: TitleCaiDatWidget(
        title: title,
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.4,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(list.length, (index) {
            final data = list[index];
            return selectImageCell(context, data);
          }),
        ),
      ),
    );
  }

  Widget selectImageCell(BuildContext context, AppBackGround appBackGround) {
    return GestureDetector(
      onTap: () {
        AppStateCt.of(context).appState.setAppBackGround(appBackGround);
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage(appBackGround.getIcon()),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: appBackGround == APP_BACKGROUND
                    ? SvgPicture.asset(ImageAssets.icCheckBoxSelect)
                    : const SizedBox(),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            appBackGround.getText(),
            style: textNormal(color667793, 14),
          )
        ],
      ),
    );
  }
}
