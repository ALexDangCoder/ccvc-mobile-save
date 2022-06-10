import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_anh_khong_deo_kinh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class TabAnhKhongDeoKinh extends StatefulWidget {
  const TabAnhKhongDeoKinh({Key? key}) : super(key: key);

  @override
  State<TabAnhKhongDeoKinh> createState() => _TabAnhKhongDeoKinhState();
}

class _TabAnhKhongDeoKinhState extends State<TabAnhKhongDeoKinh> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhChinhDien,
            title: S.current.anh_mat_nhin_chinh_dien,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhNhinSangPhai,
            title: S.current.anh_mat_nhin_sang_phai,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhNhinSangTrai,
            title: S.current.anh_mat_nhin_sang_trai,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhChupMatTuTrenXuong,
            title: S.current.anh_chup_mat_tu_tren_xuong,
          ),
          ItemAnhKhongDeoKinh(
            image: ImageAssets.imgAnhChupMatTuDuoiLen,
            title: S.current.anh_chup_mat_tu_duoi_len,
          ),
        ],
      ),
    ));
  }
}
