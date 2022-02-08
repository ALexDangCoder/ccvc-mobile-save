import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThanhPhanThamGiaTLWidget extends StatefulWidget {
  const ThanhPhanThamGiaTLWidget({Key? key}) : super(key: key);

  @override
  _ThanhPhanThamGiaTLWidgetState createState() =>
      _ThanhPhanThamGiaTLWidgetState();
}

class _ThanhPhanThamGiaTLWidgetState extends State<ThanhPhanThamGiaTLWidget> {
  bool isExpand = false;
  List<DonViModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            isExpand = !isExpand;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.thanh_phan_tham_gia,
                style: textNormalCustom(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.textScale(),
                  color: unselectedLabelColor,
                ),
              ),
              if (isExpand) const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AqiColor,
                    ) else const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AqiColor,
                    )
            ],
          ),
        ),

        SizedBox(height: 16.5.textScale(),),
        ExpandedSection(
          expand: isExpand,
          child: ThanhPhanThamGiaWidget(
            onChange: (value) {
              list = value;
            },
            phuongThucNhan: (value) {},
            isPhuongThucNhan: false,
          ),
        )
      ],
    );
  }
}
