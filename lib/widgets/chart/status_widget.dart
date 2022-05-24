import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  final List<ChartData> listData;
  final Function(String)? onSelectItem;
  final bool showZeroValue;
  final bool horizontalView;
  final String selectedKey;

  const StatusWidget({
    Key? key,
    required this.listData,
    this.onSelectItem,
    this.showZeroValue = true,
    this.horizontalView = false,
    this.selectedKey = '',
  }) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  late String sKey;

  @override
  void initState() {
    sKey = widget.selectedKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.horizontalView
        ? SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: legend()),
                const SizedBox(
                  width: 60,
                ),
                Expanded(child: legendTitle())
              ],
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              legend(),
              const SizedBox(
                height: 26,
              ),
              legendTitle()
            ],
          );
  }

  Widget legend() => Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: widget.listData
              .map(
                (e) => (e.value.toInt() == 0 && widget.showZeroValue == false)
                    ? const SizedBox.shrink()
                    : Expanded(
                        flex: e.value.toInt(),
                        child: GestureDetector(
                          onTap: () {
                            final tKey = e.key ?? '';
                            sKey = (sKey == tKey) ? '' : tKey;
                            if (widget.onSelectItem != null) {
                              // ignore: prefer_null_aware_method_calls
                              widget.onSelectItem!(sKey);
                            }
                          },
                          child: Container(
                            color: (sKey == e.key || sKey == '')
                                ? e.color
                                : e.color.withOpacity(0.2),
                            child: Center(
                              child: Text(
                                e.value.toInt().toString(),
                                style: textNormal(
                                  backgroundColorApp,
                                  14.0.textScale(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              )
              .toList(),
        ),
      );

  Widget legendTitle() => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 9,
        mainAxisSpacing: 10.0.textScale(space: 4),
        crossAxisSpacing: 10,
        children: List.generate(widget.listData.length, (index) {
          final result = widget.listData[index];
          return GestureDetector(
            onTap: () {
              final tKey = result.key ?? '';
              sKey = (sKey == tKey) ? '' : tKey;
              if (widget.onSelectItem != null) {
                // ignore: prefer_null_aware_method_calls
                widget.onSelectItem!(sKey);
              }
            },
            child: Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: (sKey == result.key || sKey == '')
                        ? result.color
                        : result.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: FittedBox(
                    child: Text(
                      '${result.title} (${result.value.toInt()})',
                      style: textNormal(
                        infoColor,
                        14.0.textScale(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      );
}
