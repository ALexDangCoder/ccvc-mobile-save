import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/widget/item_chi_tiet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowIndicatorTablet extends StatelessWidget {
  final double? paddingleft;
  final List<ChartData> chartData;

  const RowIndicatorTablet({
    Key? key,
    this.paddingleft,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingleft ?? 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0.textScale(space: 4),
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            mainAxisExtent: 60,
          ),
          itemCount: chartData.length,
          itemBuilder: (context, index) {
            final result = chartData[index];
            return GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        '${result.title} (${result.value.toInt()})',
                        style: textNormal(
                          infoColor,
                          14.0.textScale(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: result.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RowIndicatorSmallTablet extends StatelessWidget {
  final double? paddingleft;
  final List<ChartData> chartData;

  const RowIndicatorSmallTablet({
    Key? key,
    this.paddingleft,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingleft ?? 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        mainAxisSpacing: 10.0.textScale(space: 4),
        crossAxisSpacing: 10,
        children: List.generate(chartData.length, (index) {
          final result = chartData[index];
          // ignore: avoid_unnecessary_containers
          return GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: result.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    '${result.title} (${result.value.toInt()})',
                    style: textNormal(
                      infoColor,
                      14.0.textScale(),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

Widget getGridView() {
  return GridView.builder(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 16,
      bottom: 16,
    ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 17,
      crossAxisSpacing: 17,
      childAspectRatio: 1.5,
      mainAxisExtent: 130,
    ),
    itemCount: 16,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ItemChiTiet(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: backgroundColorApp,
            border: Border.all(color: borderColor.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: shadowContainerColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Image.asset(ImageAssets.icGroundMobile),
              ),
              Text(
                S.current.bac_cao,
                style: textNormal(textTitle, 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}
