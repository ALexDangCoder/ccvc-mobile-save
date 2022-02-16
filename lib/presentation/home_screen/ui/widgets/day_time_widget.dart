import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/clock_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DayTimeWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  const DayTimeWidget({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClockWidget(),
            StreamBuilder<DateModel>(
              initialData: DateModel(),
              stream: HomeProvider.of(context).homeCubit.getDateStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? DateModel();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (data.dateMore.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: FittedBox(
                          child: Text(
                            data.dateMore,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().titleColor(),
                              fontSize: 14.0.textScale(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                    Text(
                      data.lunarDate.isNotEmpty ? '(${data.lunarDate})' : '',
                      style: textNormal(
                        AqiColor.withOpacity(0.8),
                        14.0.textScale(),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(ImageAssets.icThoiTiet),
            spaceW12,
            Text(
              '32°C',
              style: textNormalCustom(fontSize: 16, color: titleColor),
            )
          ],
        )
      ],
    );
  }
}
