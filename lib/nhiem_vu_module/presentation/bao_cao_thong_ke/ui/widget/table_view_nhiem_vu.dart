import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class TableViewNhiemVu extends StatelessWidget {
  const TableViewNhiemVu({Key? key, required this.list}) : super(key: key);

  final List<NhiemVuDonVi> list;

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(
          inside: BorderSide(color: borderColor),
          outside: BorderSide(color: borderColor),
        ),
        defaultColumnWidth: FixedColumnWidth(150),
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: bgManagerColor,
            ),
            children: [
              titleCollum('Đơn vị xử lý'),
              titleCollum('Tổng số nhiệm vụ'),
              titleCollum('Hoàn thành'),
              titleCollum('Đang thực hiện'),
              titleCollum('Quá hạn'),
            ],
          ),
          TableRow(children: [
            Text(
              '2011',
            ),
            Text('Dart'),
            Text('Lars Bak'),
            Text('Lars Bak'),
            Text('Lars Bak'),
          ]),
        ]);
  }

  Widget titleCollum(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: textNormal(textTitle, 14.0.textScale()),
      ),
    );
  }
  TableRow tableRow(NhiemVuDonVi item) {
    return TableRow(
      children: [

      ]
    );
  }
}
