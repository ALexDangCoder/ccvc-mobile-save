import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/nhiem_vu_item_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListDanhSachNhiemVu extends StatefulWidget {
  final String titleButton;
  final List<DanhSachNhiemVuModel> list;
  final Function() onTap;


  const ListDanhSachNhiemVu({
    required this.titleButton,
    required this.list,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _ListDanhSachNhiemVuState createState() => _ListDanhSachNhiemVuState();
}

class _ListDanhSachNhiemVuState extends State<ListDanhSachNhiemVu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: bgQLVBTablet,
          padding: const EdgeInsets.fromLTRB(30, 60, 30,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buttonChitiet(widget.titleButton, widget.onTap),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  return NhiemVuCellTablet(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const ChiTietNhiemVuTabletScreen(),
                        ),
                      );
                    },
                    title: widget.list[index].title??'',
                    noiDung: widget.list[index].noiDung??'',
                    dateTimeStart: widget.list[index].timeStart??'',
                    dateTimeEnd:widget.list[index].timeEnd??'' ,
                    userName: widget.list[index].nguoiTao??'',
                    status: widget.list[index].trangThai??'',
                    userImage: 'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                    index: index+1,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buttonChitiet(String text, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 205,
      height: 40,
      padding: const EdgeInsets.only(left: 20),
      color: textDefault.withOpacity(0.1),
      child: Row(
        children: [
          Text(
            text,
            style: textNormalCustom(color: textDefault),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(ImageAssets.ic_chitet),
        ],
      ),
    ),
  );
}
