import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecMobile extends StatefulWidget {
  const DanhSachCongViecMobile({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecMobileState createState() => _DanhSachCongViecMobileState();
}

class _DanhSachCongViecMobileState extends State<DanhSachCongViecMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarDefaultBack(S.current.danh_sach_cong_viec) ,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0,),
            const BaseSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                child:  Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:listDanhSachCongViec.length,
                    itemBuilder: (context, index) {
                      return NhiemVuItemMobile(
                        onTap: () {},
                        title: listDanhSachCongViec[index].noiDung??'',
                        timeStart: listDanhSachCongViec[index].timeStart??'',
                        timeEnd:
                        listDanhSachCongViec[index].timeEnd??'',
                        userName: listDanhSachCongViec[index].nguoiTao??'',
                        status: listDanhSachCongViec[index].trangThai??'',
                        userImage:
                        'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
