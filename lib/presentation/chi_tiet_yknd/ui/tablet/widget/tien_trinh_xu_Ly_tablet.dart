import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:flutter/material.dart';

class TienTrinhXuLyScreenTablet extends StatefulWidget {
  final List<DataRowChiTietKienNghi> listRow;

  const TienTrinhXuLyScreenTablet({Key? key, required this.listRow}) : super(key: key);

  @override
  _TienTrinhXuLyScreenTabletState createState() => _TienTrinhXuLyScreenTabletState();
}

class _TienTrinhXuLyScreenTabletState extends State<TienTrinhXuLyScreenTablet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16),
      decoration: BoxDecoration(
        color: colorE2E8F0.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: colorE2E8F0),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.listRow.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 16),
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
