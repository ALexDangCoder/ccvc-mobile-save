import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/tablet/chi_tiet_cong_viec_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListDanhSachCongViec extends StatefulWidget {
  final String titleButton;
  final List<PageDatas> list;
  final Function() onTap;

  const ListDanhSachCongViec({
    required this.titleButton,
    required this.list,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _ListDanhSachCongViecState createState() => _ListDanhSachCongViecState();
}

class _ListDanhSachCongViecState extends State<ListDanhSachCongViec> {
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
                          builder: (context) => ChitietCongViecNhiemVuTablet(
                            id: widget.list[index].id ?? '',
                          ),
                        ),
                      );
                    },
                    title: widget.list[index].maCv ?? '',
                    noiDung:
                        (widget.list[index].noiDungCongViec ?? '').parseHtml(),
                    userName: widget.list[index].doiTuongThucHien ?? '',
                    status: widget.list[index].trangThai ?? '',
                    index: index + 1,
                    hanXuLy: widget.list[index].hanXuLy ??
                        DateTime.now().formatDdMMYYYY,
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
      color: AppTheme.getInstance().colorField().withOpacity(0.1),
      child: Row(
        children: [
          Text(
            text,
            style: textNormalCustom(color: AppTheme.getInstance().colorField()),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(ImageAssets.ic_chitet,color: AppTheme.getInstance().colorField(),),
        ],
      ),
    ),
  );
}
