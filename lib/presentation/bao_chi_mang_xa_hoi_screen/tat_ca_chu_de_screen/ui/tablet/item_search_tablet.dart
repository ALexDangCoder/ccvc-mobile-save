import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ItemSearch extends StatelessWidget {
  final String title;
  final Function() onClick;

  const ItemSearch({Key? key, required this.title, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().sideTextInactiveColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                title,
                style: textNormalCustom(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: infoColor,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onClick();
      },
    );
  }
}
