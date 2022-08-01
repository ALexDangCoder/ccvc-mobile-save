import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: textNormalCustom(
            fontSize: 16,
            color: AppTheme.getInstance().titleColor(),
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            child: ImageAssets.svgAssets(ImageAssets.icBack),
          ),
        ),
      ),
      body: Center(
        child: Text(S.current.coming_soon,
            style: textNormalCustom(
              fontSize: 16,
              color: AppTheme.getInstance().titleColor(),
            )),
      ),
    );
  }
}
