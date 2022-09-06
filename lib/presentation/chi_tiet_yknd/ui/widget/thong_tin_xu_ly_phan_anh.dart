import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:flutter/material.dart';

class ThongTinXuLyPhanAnh extends StatefulWidget {
  final List<DataRowChiTietKienNghi> listRow;

  const ThongTinXuLyPhanAnh({Key? key, required this.listRow})
      : super(key: key);

  @override
  _ThongTinXuLyPhanAnhState createState() => _ThongTinXuLyPhanAnhState();
}

class _ThongTinXuLyPhanAnhState extends State<ThongTinXuLyPhanAnh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: bgDropDown),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.listRow.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: ItemRow(
              title: widget.listRow[index].title,
              content: widget.listRow[index].content,
            ),
          );
        },
      ),
    );
  }
}
