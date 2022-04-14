import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/menu/ui/widget/container_ket_noi_tablet_menu.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KetNoiMenuTablet extends StatefulWidget {
  final Function(LoaiBaiVietModel) onChange;
  final List<LoaiBaiVietModel> listData;

  const KetNoiMenuTablet({
    Key? key,
    required this.onChange,
    required this.listData,
  }) : super(key: key);

  @override
  _KetNoiMenuTabletState createState() => _KetNoiMenuTabletState();
}

class _KetNoiMenuTabletState extends State<KetNoiMenuTablet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: BaseAppBar(
        title: S.current.menu,
        leadingIcon: IconButton(
          icon: SvgPicture.asset(
            ImageAssets.icX,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 28, right: 28, top: 12, bottom: 28),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.listData.length,
                    itemBuilder: (context, index) {
                      return items(widget.listData[index]);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget items(LoaiBaiVietModel data) {
    return ContainerKetNoiTablet(
      data: data,
      childExpand: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.childrens?.length ?? 0,
        itemBuilder: (context, index) {
          return items(data.childrens?[index] ?? LoaiBaiVietModel());
        },
      ),
      onTap: () {
        widget.onChange(data);
        setState(() {});
      },
    );
  }
}
