import 'dart:io';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:flutter/cupertino.dart';

class TaiLieuWidget extends StatefulWidget {
  const TaiLieuWidget({Key? key}) : super(key: key);

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        title: S.current.tai_lieu,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ButtonSelectFile(
            title: S.current.them_tai_lieu_cuoc_hop,
            onChange: (List<File> files) {
              print(files);
            },
            files: [],
          ),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60, left: 13.5),
        child: ButtonSelectFile(
          title: S.current.them_tai_lieu_cuoc_hop,
          onChange: (List<File> files) {
            print(files);
          },
          files: [],
        ),
      ),
    );
  }
}
