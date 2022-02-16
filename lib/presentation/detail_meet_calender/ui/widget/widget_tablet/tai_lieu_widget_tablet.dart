import 'dart:io';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/material.dart';

class TaiLieuWidgetTablet extends StatefulWidget {
  const TaiLieuWidgetTablet({Key? key}) : super(key: key);

  @override
  _TaiLieuWidgetTabletState createState() => _TaiLieuWidgetTabletState();
}

class _TaiLieuWidgetTabletState extends State<TaiLieuWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60,left: 13.5),
      child: ButtonSelectFile(
        icon: ImageAssets.icDocument2,
        title: S.current.them_tai_lieu_cuoc_hop,
        onChange: (List<File> files) {
          print(files);
        }, files: [],
      ),
    );
  }
}
