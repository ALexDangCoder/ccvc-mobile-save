import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/tablet/list/widget/item_list_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhSachBaoCaoDangListViewTablet extends StatefulWidget {
  const DanhSachBaoCaoDangListViewTablet({Key? key}) : super(key: key);

  @override
  _DanhSachBaoCaoDangListViewTabletState createState() =>
      _DanhSachBaoCaoDangListViewTabletState();
}

class _DanhSachBaoCaoDangListViewTabletState
    extends State<DanhSachBaoCaoDangListViewTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWidgets,
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgWidgets,
        title: S.current.bac_cao,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset(ImageAssets.icListHopTablet),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 28),
          child: ListView.builder(
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ItemListTablet();
            },
          ),
        ),
      ),
    );
  }
}
