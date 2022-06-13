import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/tab_danh_ba_ca_nhan.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/tab_danh_ba_to_chuc.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhBaDienTuTablet extends StatefulWidget {
  const DanhBaDienTuTablet({Key? key}) : super(key: key);

  @override
  _DanhBaDienTuTabletState createState() => _DanhBaDienTuTabletState();
}

class _DanhBaDienTuTabletState extends State<DanhBaDienTuTablet>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgManagerColor,
        elevation: 0.7,
        title: Text(
          S.current.danh_ba_dien_tu,
          style: titleAppbar(),
        ),
        centerTitle: true,
        actions: const [],
        leading: IconButton(
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: AppTheme.getInstance().colorField(),
          unselectedLabelColor: unselectLabelColor,
          labelColor: AppTheme.getInstance().colorField(),
          tabs: [
            Tab(
              child: Text(
                S.current.danh_ba_to_chuc,
              ),
            ),
            Tab(
              child: Text(S.current.danh_ba_ca_nhan),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [DanhBaToChuc(), DanhBaCaNhan()],
      ),
    );
  }
}
