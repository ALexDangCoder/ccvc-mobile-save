import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListDanhSachNhiemVu extends StatefulWidget {
  final String titleButton;
  final List<PageData> list;
  final Function() onTap;
  final bool isCheck;

  const ListDanhSachNhiemVu({
    required this.titleButton,
    required this.list,
    required this.onTap,
    required this.isCheck,
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
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
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
                itemCount: widget.list.length < 3 ? widget.list.length : 3,
                itemBuilder: (context, index) {
                  return NhiemVuCellTablet(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChiTietNhiemVuTabletScreen(
                            id: widget.list[index].id ?? '',
                            isCheck: widget.isCheck,
                          ),
                        ),
                      );
                    },
                    title: widget.list[index].loaiNhiemVu ?? '',
                    noiDung:
                        (widget.list[index].noiDungTheoDoi ?? '').parseHtml(),
                    hanXuLy: widget.list[index].hanXuLy ??
                        DateTime.now().formatDdMMYYYY,
                    userName: widget.list[index].tinhHinhThucHienNoiBo ?? '',
                    status: widget.list[index].trangThai ?? '',
                    index: index + 1,
                    maTrangThai: widget.list[index].maTrangThai ?? '',
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
