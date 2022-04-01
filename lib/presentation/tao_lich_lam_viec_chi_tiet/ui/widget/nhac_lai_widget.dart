import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class NhacLaiWidget extends StatefulWidget {
  const NhacLaiWidget({Key? key}) : super(key: key);

  @override
  _NhacLaiWidgetState createState() => _NhacLaiWidgetState();
}

class _NhacLaiWidgetState extends State<NhacLaiWidget> {
  @override
  Widget build(BuildContext context) {
    return SelectOnlyExpand(
      urlIcon: ImageAssets.icNotify,
      listSelect: listTime.map<String>((e) => e.text).toList(),
      title: S.current.nhac_lich,
    );
  }
}
