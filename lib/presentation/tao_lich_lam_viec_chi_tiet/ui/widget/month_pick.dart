import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/table_pick_date.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MonthPickerCus extends StatefulWidget {
  int year;
  int month;

  MonthPickerCus({
    Key? key,
    required this.year,
    required this.month,
  }) : super(key: key);

  @override
  State<MonthPickerCus> createState() => _MonthPickerCusState();
}

class _MonthPickerCusState extends State<MonthPickerCus> {
  int index = 13;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().backGroundColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.year--;
                            setState(() {});
                          },
                          behavior: HitTestBehavior.opaque,
                          child: ImageAssets.svgAssets(
                            ImageAssets.icBack,
                          ),
                        ),
                        const SizedBox(
                          width: 34,
                        ),
                        Text(
                          widget.year.toString(),
                          style: textNormalCustom(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppTheme.getInstance().titleColor()
                          ),
                        ),
                        const SizedBox(
                          width: 34,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.year++;
                            setState(() {});
                          },
                          behavior: HitTestBehavior.opaque,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: ImageAssets.svgAssets(
                              ImageAssets.icBack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      thickness: 0.5,
                      color: AppTheme.getInstance().disableColor(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.custom(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: _dayPickerGridDelegate,
                        childrenDelegate: SliverChildListDelegate(
                          monthOfYear(),
                          addRepaintBoundaries: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 39,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> monthOfYear() {
    List<Widget> listMonth = [];
    for (int i = 1; i < 13; i++) {
      listMonth.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 7),
        child: GestureDetector(
          onTap: () {
            setState(() {
              index = i;
              widget.month = i;
              Navigator.pop(context, [widget.month, widget.year]);
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
              color: i == index
                  ? AppTheme.getInstance().primaryColor()
                  : AppTheme.getInstance().backGroundColor(),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              i.monthToString(),
              style: textNormalCustom(
                color: i == index
                    ? AppTheme.getInstance().backGroundColor()
                    : AppTheme.getInstance().dfTxtColor(),
              ),
            ),
          ),
        ),
      ));
    }
    return listMonth;
  }
}

class _MonthPickerGridDelegate extends SliverGridDelegate {
  const _MonthPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = 3;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    const double tileHeight = 56;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_MonthPickerGridDelegate oldDelegate) => false;
}

const _MonthPickerGridDelegate _dayPickerGridDelegate =
    _MonthPickerGridDelegate();
