import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {
  const MySeparator({
    Key? key,
    this.width = 1,
    this.color = colorBlack,
    this.height = 10,
    required this.dashCountRow,
    required this.heSo,
    required this.scale,
  }) : super(key: key);
  final double width;
  final Color color;
  final double height;
  final int dashCountRow;
  final int heSo;
  final int scale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashHeight = 6.0;
        final dashWidth = width;
        final dashCount = (height / (dashHeight * 1.5)).floor() + 1;
        return Row(
          children: List.generate(dashCountRow, (index) {
            final String indexTrucHoanh = (index * scale).toString();
            return SizedBox(
              width: (heSo * scale).toDouble(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: List.generate(dashCount, (_) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: dashHeight / 2),
                        child: SizedBox(
                          height: dashHeight,
                          width: dashWidth,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: color),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    indexTrucHoanh,
                    style: textNormal(
                      coloriCon,
                      12,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
