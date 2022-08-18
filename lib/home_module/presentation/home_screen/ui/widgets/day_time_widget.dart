import 'package:ccvc_mobile/home_module/domain/model/home/weather_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/date_model.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/widgets/clock_widget.dart';
import '/home_module/utils/constants/image_asset.dart';

class DayTimeWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;

  const DayTimeWidget({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ClockWidget(),
                const SizedBox(
                  height: 6,
                ),
                StreamBuilder<DateModel>(
                  initialData: DateModel(),
                  stream: HomeProvider
                      .of(context)
                      .homeCubit
                      .getDateStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? DateModel();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (data.dateMore.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: FittedBox(
                              child: Text(
                                data.dateMore,
                                style: textNormalCustom(
                                  color: textTitle,
                                  fontSize: 12.0.textScale(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        else
                          const SizedBox(),
                        Text(
                          data.lunarDate.isNotEmpty
                              ? '(${data.lunarDate})'
                              : '',
                          style: textNormal(
                            AqiColor.withOpacity(0.8),
                            12.0.textScale(),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ],
        ),
        StreamBuilder<WeatherModel>(
            stream: HomeProvider
                .of(context)
                .homeCubit
                .weatherSubject
                .stream,

            builder: (context, snapshot) {
              final data = snapshot.data;
              return Visibility(
                visible: data?.resultObj?.current?.temp?.day != null,
                child: Positioned(
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(ImageAssets.icThoiTiet),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${data?.resultObj?.current?.temp?.day.round() ?? 0}°C',
                        style: textNormalCustom(fontSize: 16, color: titleColor),
                      )
                    ],
                  ),
                ),
              );
            }
        )
      ],
    );
  }
}
