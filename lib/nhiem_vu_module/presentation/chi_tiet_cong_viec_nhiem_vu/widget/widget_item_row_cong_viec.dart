import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class WidgetItemRowCongViec extends StatelessWidget {
  final ChiTietCongViecNhiemVuRow row;

  WidgetItemRowCongViec({Key? key, required this.row}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addWidget();
    return Column(
      children: [
        spaceH10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                row.title,
                style: textDetailHDSD(
                  fontSize: 14.0.textScale(),
                  color: infoColor,
                  textHeight: 1.7,
                ),
                maxLines: 2,
              ),
            ),
            Expanded(
              flex: 6,
              child: row.title != S.current.cong_viec_lien_quan
                  ? Text(
                      row.value,
                      style: textDetailHDSD(
                        fontSize: 14.0.textScale(),
                        color: color3D5586,
                        textHeight: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  : Wrap(
                      spacing: 10, // gap between adjacent chips
                      runSpacing: 10, // gap between lines
                      children: congViecLQ,
                    ),
            )
          ],
        )
      ],
    );
  }

  final List<Widget> congViecLQ = [];

  void addWidget() {
    row.list?.forEach((element) {
      congViecLQ.add(
        InkWell(
          onTap: () {

          },
          child: Text(
            element.sTT ?? '',
            style: textDetailHDSD(
              fontSize: 14.0.textScale(),
              color: color125DF2,
              textHeight: 1.7,
            ).copyWith(
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    });
  }
}
