import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/danh_sach_bao_cao_dang_girdview.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemFolder extends StatelessWidget {
  const ItemFolder({
    Key? key,
    required this.type,
    this.soFile,
    this.isChiaSe = false,
    this.isItemListView = false,
    //   required this.funChiaSe,
  }) : super(key: key);
  final TypeLoai type;
  final int? soFile;
  final bool isChiaSe;
  final bool isItemListView;

  //final Function funChiaSe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          type == TypeLoai.THU_MUC
              ? ImageAssets.icFileSvg
              : ImageAssets.icBaoCaoSvg,
          width: isItemListView
              ? type == TypeLoai.THU_MUC
                  ? 40
                  : 33.33
              : type == TypeLoai.THU_MUC
                  ? 44
                  : 40,
          height: isItemListView
              ? type == TypeLoai.THU_MUC
                  ? 36.38
                  : 33.33
              : type == TypeLoai.THU_MUC
                  ? 44
                  : 40,
        ),
        Positioned(
          left: -3,
          bottom: -2,
          child: isChiaSe
              ? SvgPicture.asset(
                  ImageAssets.icChiaSeSvg,
                  width: 16,
                  height: 16,
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Text(
            (soFile ?? 0).toString(),
            style: textNormalCustom(
              fontSize: 12.0,
              color: titleCalenderWork,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
