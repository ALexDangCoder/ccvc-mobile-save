import 'package:ccvc_mobile/generated/l10n.dart';
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
    return Column(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.symmetric(
            inside: const BorderSide(color: borderColor),
            outside: const BorderSide(color: borderColor),
          ),
          columnWidths: const {
            0: FixedColumnWidth(130),
            1: FixedColumnWidth(130),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(100),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: bgManagerColor,
              ),
              children: [
                titleCollum(S.current.don_vi_xu_ly),
                titleCollum(S.current.tong_so_nhiem_vu),
                titleCollum(S.current.hoan_thanh),
                titleCollum(S.current.dang_thuc_hien),
                titleCollum(S.current.qua_han),
              ],
            ),
          ],
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.symmetric(
            inside: const BorderSide(color: borderColor),
            outside: const BorderSide(color: borderColor),
          ),
          columnWidths: const {
            0: FixedColumnWidth(130),
            1: FixedColumnWidth(130),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(100),
          },
          children: list.map((e) => tableRow(e)).toList(),
        ),
      ],
    );
  }

  Widget titleCollum(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 10,
      ),
      child: Text(
        title,
        style: textNormalCustom(
          color: textTitle,
          fontSize: 12.0.textScale(),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  TableRow tableRow(NhiemVuDonVi item) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            bottom: 10,
          ),
          child: Text(
            item.name ?? '',
            style: textNormal(textTitle, 12.0.textScale()),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              item.tongSoNhiemVu.toString(),
              style: textNormal(textTitle, 12.0.textScale()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14,
                width: item.tongSoNhiemVu != 0
                    ? ((item.nhiemVuHoanThanh ?? 0) /
                        (item.tongSoNhiemVu ?? 0) *
                        30)
                    : 0,
                color: colorGreen,
              ),
              Text(
                '${item.tongSoNhiemVu != 0 ? ((item.nhiemVuHoanThanh ?? 0) / (item.tongSoNhiemVu ?? 0) * 100).toStringAsFixed(2) : 0}%',
                style: textNormal(textTitle, 12.0.textScale()),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14,
                width: item.tongSoNhiemVu != 0
                    ? ((item.nhiemVuChuaHoanThanh ?? 0) /
                        (item.tongSoNhiemVu ?? 0) *
                        30)
                    : 0,
                color: colorOrange,
              ),
              Text(
                '${item.tongSoNhiemVu != 0 ? ((item.nhiemVuChuaHoanThanh ?? 0) / (item.tongSoNhiemVu ?? 0) * 100).toStringAsFixed(2) : 0}%',
                style: textNormal(textTitle, 12.0.textScale()),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14,
                width: item.tongSoNhiemVu != 0
                    ? ((item.nhiemVuQuaHan ?? 0) /
                        (item.tongSoNhiemVu ?? 0) *
                        30)
                    : 0,
                color: colorRed,
              ),
              Text(
                '${item.tongSoNhiemVu != 0 ? ((item.nhiemVuQuaHan ?? 0) / (item.tongSoNhiemVu ?? 0) * 100).toStringAsFixed(2) : 0}%',
                style: textNormal(textTitle, 12.0.textScale()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
