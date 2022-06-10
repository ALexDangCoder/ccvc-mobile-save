import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_anh_khong_deo_kinh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class TabAnhKhongDeoKinhTablet extends StatefulWidget {
  const TabAnhKhongDeoKinhTablet({Key? key}) : super(key: key);

  @override
  State<TabAnhKhongDeoKinhTablet> createState() =>
      _TabAnhKhongDeoKinhTabletState();
}

class _TabAnhKhongDeoKinhTabletState extends State<TabAnhKhongDeoKinhTablet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhChinhDien,
                    title: S.current.anh_mat_nhin_chinh_dien,
                  ),
                ),
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhNhinSangPhai,
                    title: S.current.anh_mat_nhin_sang_phai,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhNhinSangTrai,
                    title: S.current.anh_mat_nhin_sang_trai,
                  ),
                ),
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhChupMatTuTrenXuong,
                    title: S.current.anh_chup_mat_tu_tren_xuong,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ItemAnhKhongDeoKinh(
                    image: ImageAssets.imgAnhChupMatTuDuoiLen,
                    title: S.current.anh_chup_mat_tu_duoi_len,
                  ),
                ),
                Expanded(child: SizedBox())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
