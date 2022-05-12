import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';
class TabThongTinPAKN extends StatefulWidget {
  const TabThongTinPAKN({Key? key}) : super(key: key);

  @override
  State<TabThongTinPAKN> createState() => _TabThongTinPAKNState();
}

class _TabThongTinPAKNState extends State<TabThongTinPAKN> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          RowTitleFeatDescription(title: S.current.tieu_de, description: fakeData[0]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.noi_dung, description: fakeData[1]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.nguon_pakn, description: fakeData[2]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.phan_loai, description: fakeData[3]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.linh_vuc, description: fakeData[4]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.ngay_phan_anh, description: fakeData[5]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.han_xu_ly, description: fakeData[6]),
          spaceH10,
          RowTitleFeatDescription(title: S.current.tai_lieu_dinh_kem_cong_dan, description: fakeData[7]),
        ],
      ),
    );
  }
}


List<String> fakeData = [
  'Đóng BHXK tự nguyện online',
  'Đề nghị ban quản trị kiểm tra dịch vụ thanh toán BHXH tự nguyện theo hình thức online. Tôi muốn thanh toán online nhưng không thể thực hiện được, hệ thống báo là số thẻ ngân hàng không chính xác mặc dù thẻ ngân hàng tôi vẫn đang sử dụng bình thường.',
  'Cổng TTĐT của Bộ',
  'Hành vi của cán bộ, công chức, viên chứ',
  'Bảo hiểm',
  '22/10/2021',
  '24/05/2022',
  'file.pdf',
];
