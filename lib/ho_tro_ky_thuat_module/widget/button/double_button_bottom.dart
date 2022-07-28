import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class DoubleButtonBottom extends StatelessWidget {
  final String title1;
  final String title2;

  final Function onPressed1;
  final Function onPressed2;
  final bool isTablet;
  final bool noPadding;
  final double? height;
  final bool disableRightButton;
  final bool onlyOneButton;

  const DoubleButtonBottom({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onPressed1,
    required this.onPressed2,
    this.isTablet = false,
    this.noPadding = false,
    this.height,
    this.disableRightButton = false,
    this.onlyOneButton = false,
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
                spaceW20,
                if (!onlyOneButton)
                  button(
                    onTap: () {
                      onPressed2();
                    },
                    disable: disableRightButton,
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
                    onPressed1();
                  },
                  child: Container(
                    height: height ?? 40.0.textScale(space: 16.0),
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
              if (!onlyOneButton) ...[
                SizedBox(width: 16.0.textScale(space: 8.0)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!disableRightButton) {
                        onPressed2();
                      }
                    },
                    child: Container(
                      height: height ?? 40.0.textScale(space: 16.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(4.0.textScale(space: 4.0)),
                        color: (!disableRightButton)
                            ? AppTheme.getInstance().colorField()
                            : AppTheme.getInstance()
                                .unselectColor()
                                .withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text(
                          title2,
                          style: textNormalCustom(
                            fontSize: 14.0.textScale(space: 4.0),
                            color: (!disableRightButton)
                                ? backgroundColorApp
                                : coloriCon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
        if (!disable) {
          onTap();
        }
      },
      child: Container(
        height: 44,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isLeft
              ? AppTheme.getInstance().colorField().withOpacity(0.1)
              : (!disable)
                  ? AppTheme.getInstance().colorField()
                  : AppTheme.getInstance().unselectColor().withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            title,
            style: textNormalCustom(
              fontSize: 16,
              color: isLeft
                  ? AppTheme.getInstance().colorField()
                  : (!disable)
                      ? backgroundColorApp
                      : coloriCon,
            ),
          ),
        ),
      ),
    );
  }
}
