import 'package:ccvc_mobile/bao_cao_module/domain/model/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/tablet/widget/item_nguoi_dung_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChonNhomTabletWidget extends StatefulWidget {
  const ChonNhomTabletWidget({
    Key? key,
    required this.item,
    required this.delete,
  }) : super(key: key);

  final NhomCungHeThong item;
  final Function delete;

  @override
  State<ChonNhomTabletWidget> createState() => _ChonNhomTabletWidgetState();
}

class _ChonNhomTabletWidgetState extends State<ChonNhomTabletWidget> {
  bool showFull = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32.w,
              height: 32,
              decoration: BoxDecoration(
                color: color4C6FFF.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImageAssets.img_companies_svg,
                height: 5,
                width: 5.w,
                color: Colors.blue,
                fit: BoxFit.none,
              ),
            ),
            spaceW5,
            Text(
              widget.item.tenNhom ?? '',
              style: textNormalCustom(
                color: color3D5586,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            spaceW12,
            InkWell(
              onTap: () {
                widget.delete();
              },
              child: const Icon(
                Icons.close,
                size: 18,
                color: colorA2AEBD,
              ),
            ),
          ],
        ),
        spaceH12,
        if ((widget.item.listThanhVien?.length ?? 0) > 0)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if ((widget.item.listThanhVien?.length ?? 0) > 3) ...[
                  ItemNguoiDungTablet(
                    hasFunction: false,
                    name: widget.item.listThanhVien?[0].tenThanhVien ?? '',
                  ),
                  spaceW12,
                  ItemNguoiDungTablet(
                    hasFunction: false,
                    name: widget.item.listThanhVien?[1].tenThanhVien ?? '',
                  ),
                  spaceW12,
                  ItemNguoiDungTablet(
                    hasFunction: false,
                    name: widget.item.listThanhVien?[2].tenThanhVien ?? '',
                  ),
                  spaceW12,
                  if (!showFull)
                    InkWell(
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: color4C6FFF.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '+${(widget.item.listThanhVien?.length ?? 0) - 3}',
                            style: textNormalCustom(
                              color: color4C6FFF,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: (widget.item.listThanhVien?.length ?? 0) - 3,
                        itemBuilder: (context, int index) {
                          return Row(
                            children: [
                              ItemNguoiDungTablet(
                                hasFunction: false,
                                name: widget.item.listThanhVien?[index + 3]
                                        .tenThanhVien ??
                                    '',
                              ),
                              spaceW12,
                            ],
                          );
                        },
                      ),
                    ),
                ] else
                  SizedBox(
                    height: 40.h,
                    width: 544.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.item.listThanhVien?.length ?? 0,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            ItemNguoiDungTablet(
                              hasFunction: false,
                              name: widget.item.listThanhVien?[index]
                                      .tenThanhVien ??
                                  '',
                            ),
                            spaceW12,
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
