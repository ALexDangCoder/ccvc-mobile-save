import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_anh_khong_deo_kinh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/styles.dart';
import 'package:flutter/material.dart';

class TabAnhDeoKinhTablet extends StatefulWidget {
  const TabAnhDeoKinhTablet({Key? key}) : super(key: key);

  @override
  State<TabAnhDeoKinhTablet> createState() => _TabAnhDeoKinhTabletState();
}

class _TabAnhDeoKinhTabletState extends State<TabAnhDeoKinhTablet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhChinhDienDeoKinh,
                    title: S.current.anh_mat_nhin_chinh_dien,
                  ),
                ),
                spaceW13,
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhNhinSangPhaiDeoKinh,
                    title: S.current.anh_mat_nhin_sang_phai,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhNhinSangTraiDeoKinh,
                    title: S.current.anh_mat_nhin_sang_trai,
                  ),
                ),
                spaceW13,
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhChupMatTuTrenXuongDeoKinh,
                    title: S.current.anh_chup_mat_tu_tren_xuong,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhChupMatTuDuoiLenDeoKinh,
                    title: S.current.anh_chup_mat_tu_duoi_len,
                  ),
                ),
                spaceW13,
                Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
