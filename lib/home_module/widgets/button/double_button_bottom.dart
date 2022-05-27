import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  onTap: () {
                    onPressed1();
                  },
                  title: title1,
                ),
                const SizedBox(
                  width: 20,
                ),
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
                    // AppTheme.getInstance().colorSelect()
                  },
                  child: Container(
                    height: 40.0.textScale(space: 16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(4.0.textScale(space: 4.0)),
                      color:
                          AppTheme.getInstance().colorSelect().withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        title1,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(space: 4.0),
                          color: AppTheme.getInstance().colorSelect(),
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
                      color: AppTheme.getInstance().colorSelect(),
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
          color: isLeft ? buttonColor2 : textDefault,
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: 16,
              color: isLeft
                  ? AppTheme.getInstance().colorSelect()
                  : backgroundColorApp,
            ),
          ),
        ),
      ),
    );
  }
}
