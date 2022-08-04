import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DoubleButtonBottom extends StatelessWidget {
  final String title1;
  final String title2;

  final Function onPressed1;
  final Function onPressed2;
  final bool isTablet;

  const DoubleButtonBottom({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onPressed1,
    required this.onPressed2,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isTablet
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  onTap: () {
                    onPressed1();
                  },
                  title: title1,
                ),
                spaceW20,
                button(
                  onTap: () {
                    onPressed2();
                  },
                  title: title2,
                  isLeft: false,
                )
              ],
            ),
          )
        : Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onPressed1();
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
                    onPressed2();
                  },
                  child: Container(
                    height: 40.0.textScale(space: 16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(4.0.textScale(space: 4.0)),
                      color: AppTheme.getInstance().colorField(),
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
              : AppTheme.getInstance().colorField(),
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
