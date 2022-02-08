import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:flutter/material.dart';

class KhachMoiWidget extends StatelessWidget {
  const KhachMoiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleChildWidget(
      title: S.current.don_vi_phoi_hop_khac,
      sizeTitle: 14,
      child: Column(
        children: [
          SolidButton(
            onTap: () {},
            text: S.current.khach_moi,
            urlIcon: ImageAssets.icAddButtonCalenderTablet,
          )
        ],
      ),
    );
  }
}
