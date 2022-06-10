import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_anh_khong_deo_kinh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class TabAnhDeoKinh extends StatefulWidget {
  const TabAnhDeoKinh({Key? key}) : super(key: key);

  @override
  State<TabAnhDeoKinh> createState() => _TabAnhDeoKinhState();
}

class _TabAnhDeoKinhState extends State<TabAnhDeoKinh> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhChinhDienDeoKinh,
            title: S.current.anh_mat_nhin_chinh_dien,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhNhinSangPhaiDeoKinh,
            title: S.current.anh_mat_nhin_sang_phai,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhNhinSangTraiDeoKinh,
            title: S.current.anh_mat_nhin_sang_trai,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhChupMatTuTrenXuongDeoKinh,
            title: S.current.anh_chup_mat_tu_tren_xuong,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhChupMatTuDuoiLenDeoKinh,
            title: S.current.anh_chup_mat_tu_duoi_len,
          ),
        ],
      ),
    );
  }
}
