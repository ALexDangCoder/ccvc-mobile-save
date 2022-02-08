import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/don_vi_khac_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/khach_moi_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/material.dart';

class ThanhPhanThamGiaExpandWidget extends StatelessWidget {
  const ThanhPhanThamGiaExpandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding:const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.thanh_phan_tham_gia,
                style: textNormalCustom(color: titleColumn, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThanhPhanThamGiaWidget(
            isPhuongThucNhan: true,
            onChange: (value) {},
            phuongThucNhan: (value) {},
          ),
         spaceH20,
         const DonViPhoiHopKhacWidget(),
         spaceH24,
         const KhachMoiWidget(),
        ],
      ),
    );
  }
}
