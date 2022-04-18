import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/menu/ui/widget/container_ket_noi_menu.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KetNoiMenu extends StatefulWidget {
  final Function(LoaiBaiVietModel) onChange;
  final List<LoaiBaiVietModel> listData;

  const KetNoiMenu({
    Key? key,
    required this.onChange,
    required this.listData,
  }) : super(key: key);

  @override
  State<KetNoiMenu> createState() => _KetNoiMenuState();
}

class _KetNoiMenuState extends State<KetNoiMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 58,
          ),
          headerWidget(menu: S.current.ket_noi),
          const SizedBox(
            height: 24,
          ),
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
    );
  }

  Widget items(LoaiBaiVietModel data) {
    return ContainerKetNoiMenuWidget(
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

  Widget headerWidget({required String menu}) {
    return Row(
      children: [
        spaceW12,
        SvgPicture.asset(ImageAssets.ic_ket_noi),
        spaceW12,
        Text(
          menu,
          style: textNormalCustom(
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
