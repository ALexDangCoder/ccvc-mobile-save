import 'dart:io';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/material.dart';

class TaiLieuWidget extends StatefulWidget {
  const TaiLieuWidget({Key? key}) : super(key: key);

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.tai_lieu,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ButtonSelectFile(
          icon: ImageAssets.icDocument2,
          title: S.current.them_tai_lieu_cuoc_hop,
          onChange: (List<File> files) {
            print(files);
          }, files: [],
        ),
      ),
    );
  }
}
