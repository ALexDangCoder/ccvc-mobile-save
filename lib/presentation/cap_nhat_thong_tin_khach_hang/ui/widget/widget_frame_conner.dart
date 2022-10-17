import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class WidgetFrameConner extends StatelessWidget {
  const WidgetFrameConner({Key? key , this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         if (child != null)Positioned.fill(child: child!),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16.0,
                  width: 16,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                      top: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 16.0,
                  width: 16,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                      left: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16.0,
                  width: 16,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                      top: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 16.0,
                  width: 16,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                      right: BorderSide(
                        color: AppTheme.getInstance().colorField(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
