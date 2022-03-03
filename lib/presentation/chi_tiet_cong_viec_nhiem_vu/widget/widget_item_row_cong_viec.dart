import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:flutter/material.dart';

class WidgetItemRowCongViec extends StatelessWidget {
  final ChiTietCongViecNhiemVuRow row;

  const WidgetItemRowCongViec({Key? key, required this.row}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 14.0,
                  color: infoColor,
                  textHeight: 1.7,
                ),
                maxLines: 2,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                row.value,
                style: textDetailHDSD(
                  fontSize: 14.0,
                  color: titleColor,
                  textHeight: 1.7,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )
      ],
    );
  }
}
