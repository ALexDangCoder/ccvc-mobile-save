import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/clock_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/info_user_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/mequee_widget.dart';

import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class HeaderTabletWidget extends StatelessWidget {
  const HeaderTabletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -104),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.imgHeaderTablet),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: shadowContainerColor.withOpacity(0.1),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: InfoUserWidget(),
                ),
                Container(
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  color: borderItemCalender,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      StreamBuilder<DateModel>(
                        initialData: DateModel(),
                        stream:
                            HomeProvider.of(context).homeCubit.getDateStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? DateModel();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ClockWidget(),
                              Expanded(
                                child: Row(
                                  children: [
                                    if (data.dateMore.isNotEmpty)
                                      FittedBox(
                                        child: Text(
                                          data.dateMore,
                                          style: textNormalCustom(
                                            color: AppTheme.getInstance()
                                                .titleColor(),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                    spaceW12,
                                    if (data.lunarDate.isNotEmpty)
                                      Expanded(
                                        child: FittedBox(
                                          child: Text(
                                            data.lunarDate.isNotEmpty
                                                ? '(${data.lunarDate})'
                                                : '',
                                            style: textNormal(
                                              AqiColor.withOpacity(0.8),
                                              16,
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      const SizedBox()
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      Positioned(
                        right: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(ImageAssets.icThoiTiet),
                            spaceW12,
                            Text(
                              '32°C',
                              style: textNormalCustom(
                                fontSize: 20,
                                color: titleColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            left: 30,
            right: 0,
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: const MarqueeWidget(),
            ),
          )
        ],
      ),
    );
  }
}
