import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';

class DanhSachNhiemVuMobile extends StatefulWidget {
  const DanhSachNhiemVuMobile({Key? key}) : super(key: key);

  @override
  _DanhSachNhiemVuMobileState createState() => _DanhSachNhiemVuMobileState();
}

class _DanhSachNhiemVuMobileState extends State<DanhSachNhiemVuMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarDefaultBack(S.current.danh_sach_nhiem_vu) ,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0,),
            const BaseSearchBar(),
            const SizedBox(height: 16.0,),
            Expanded(
              child: SingleChildScrollView(
                child:  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:listDanhSachNhiemVu.length,
                  itemBuilder: (context, index) {
                    return NhiemVuItemMobile(
                      onTap: () {},
                      title: listDanhSachNhiemVu[index].noiDung??'',
                      timeStart:
                      listDanhSachNhiemVu[index].timeStart??'',
                      timeEnd:listDanhSachNhiemVu[index].timeEnd??'',
                      userName: listDanhSachNhiemVu[index].nguoiTao??'',
                      status: listDanhSachNhiemVu[index].trangThai??'',
                      userImage:
                      'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
