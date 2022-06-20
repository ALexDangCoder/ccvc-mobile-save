import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/presentation/chia_se_bao_cao/ui/mobile/widget/item_nguoi_dung.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChonNhomWidget extends StatelessWidget {
  const ChonNhomWidget({Key? key, required this.item, required this.delete}) : super(key: key);

  final NhomCungHeThong item;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: color4C6FFF.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                ImageAssets.img_company,
                height: 5.h,
                width: 5.w,
                color: Colors.blue,
              ),
            ),
            spaceW5,
            Text(
              item.tenNhom ?? '',
              style: textNormalCustom(
                color: color3D5586,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            spaceW12,
            InkWell(
              onTap: () {
                delete();
              },
              child: Icon(
                Icons.close,
                size: 18.sp,
                color: colorA2AEBD,
              ),
            ),
          ],
        ),
        spaceH12,
        if((item.listThanhVien?.length ?? 0) > 0)
          Row(
          children: [
            if ((item.listThanhVien?.length ?? 0) > 2) ...[
              ItemNguoiDung(
                hasFunction: false,
                name: item.listThanhVien?[0].tenThanhVien ?? '',
              ),
              spaceW12,
              ItemNguoiDung(
                hasFunction: false,
                name: item.listThanhVien?[1].tenThanhVien ?? '',
              ),
              spaceW10,
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: color4C6FFF.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                      '+${(item.listThanhVien?.length ?? 0) - 2}',
                    style: textNormalCustom(
                      color: color4C6FFF,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else
              SizedBox(
                height: 40.h,
                width: 341.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: item.listThanhVien?.length ?? 0,
                  itemBuilder: (context, int index) {
                    return Row(
                      children: [
                        ItemNguoiDung(
                          hasFunction: false,
                          name: item.listThanhVien?[index].tenThanhVien ?? '',
                        ),
                        spaceW12,
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
