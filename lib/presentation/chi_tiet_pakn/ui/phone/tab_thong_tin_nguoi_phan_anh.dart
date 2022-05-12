import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';
class TabThongTinNguoiPhanAnh extends StatefulWidget {
  const TabThongTinNguoiPhanAnh({Key? key}) : super(key: key);

  @override
  State<TabThongTinNguoiPhanAnh> createState() => _TabThongTinNguoiPhanAnhState();
}

class _TabThongTinNguoiPhanAnhState extends State<TabThongTinNguoiPhanAnh> {

  List<String> fakeData = [
    'Cá nhân',
    'Nguyễn Văn Anh',
    'Cổng TTĐT của Bộ',
    'mail@mail.com',
    '0923121245',
    'số 9 ngõ 4 - Xã Hưng Lộc - Huyện Thống Nhất - Tỉnh Đồng Nai',
    'Tỉnh Đồng Nai',
    'Huyện Xuân Lộc',
    'Xã Suối Cao'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          RowTitleFeatDescription(title: S.current.doi_tuong_nop, description: fakeData[0]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.ten_ca_nhan_tc, description: fakeData[1]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.cmt_can_cuoc, description: fakeData[2]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.dia_chi_mail, description: fakeData[3]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.so_dien_thoai, description: fakeData[4]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.dia_chi_chi_tiet, description: fakeData[5]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.tinh_cheo_thanh_pho, description: fakeData[6]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.quan_cheo_huyen, description: fakeData[7]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.xa_cheo_phuong, description: fakeData[8]),
        ],
      ),
    );
  }
}


