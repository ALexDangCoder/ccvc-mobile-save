import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/date_model.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/home_icon_tablet.dart';
import '/home_module/presentation/home_screen/ui/widgets/clock_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/info_user_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/mequee_widget.dart';
import '/home_module/utils/constants/image_asset.dart';

class HeaderTabletWidget extends StatelessWidget {
  const HeaderTabletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -63),
            child: Container(
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(headerUrlIcon()),
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
                                      Expanded(
                                        child: FittedBox(
                                          child: Text(
                                            data.dateMore,
                                            style: textNormalCustom(
                                              color: textTitle,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                    const SizedBox(
                                      width: 12,
                                    ),
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
                            const SizedBox(
                              width: 12,
                            ),
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
        ],
      ),
    );
  }
}
