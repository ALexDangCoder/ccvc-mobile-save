import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/item_row.dart';
import 'package:flutter/material.dart';

class ChiTietYKNDHeaderTablet extends StatefulWidget {
  final List<DataRowChiTietKienNghi> listRow;

  const ChiTietYKNDHeaderTablet({Key? key, required this.listRow}) : super(key: key);

  @override
  _ChiTietYKNDHeaderTabletState createState() => _ChiTietYKNDHeaderTabletState();
}

class _ChiTietYKNDHeaderTabletState extends State<ChiTietYKNDHeaderTablet> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.listRow.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(bottom: 24),
          child: ItemRow(
            title: widget.listRow[index].title,
            content: widget.listRow[index].content,
          ),
        );
      },
    );
  }
}


