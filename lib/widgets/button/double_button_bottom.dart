import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DoubleButtonBottom extends StatelessWidget {
  final String title1;
  final String title2;
  final bool disable;
  final Function onClickLeft;
  final Function onClickRight;
  final bool isTablet;
  final bool noPadding;

  const DoubleButtonBottom({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onClickLeft,
    required this.onClickRight,
    this.isTablet = false,
    this.disable = false,
    this.noPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isTablet
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  onTap: () {
                    onClickLeft();
                  },
                  title: title1,
                ),
                spaceW20,
                button(
                  onTap: () {
                    onClickRight();
                  },
                  disable: disable,
                  title: title2,
                  isLeft: false,
                )
              ],
            ),
          )
        : Row(
            crossAxisAlignment: noPadding
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onClickLeft();
                  },
                  child: Container(
                    height: 40.0.textScale(space: 16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(4.0.textScale(space: 4.0)),
                      color:
                          AppTheme.getInstance().colorField().withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        title1,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(space: 4.0),
                          color: AppTheme.getInstance().colorField(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0.textScale(space: 8.0)),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onClickRight();
                  },
                  child: Container(
                    height: 40.0.textScale(space: 16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(4.0.textScale(space: 4.0)),
                      color: AppTheme.getInstance()
                          .colorField()
                          .withOpacity(disable ? 0.5 : 1),
                    ),
                    child: Center(
                      child: Text(
                        title2,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(space: 4.0),
                          color: backgroundColorApp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget button({
    required Function onTap,
    required String title,
    bool isLeft = true,
    bool disable = false,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 44,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isLeft
              ? AppTheme.getInstance().colorField().withOpacity(0.1)
              : AppTheme.getInstance()
                  .colorField()
                  .withOpacity(disable ? 0.5 : 1),
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: 16,
              color: isLeft
                  ? AppTheme.getInstance().colorField()
                  : backgroundColorApp,
            ),
          ),
        ),
      ),
    );
  }
}
