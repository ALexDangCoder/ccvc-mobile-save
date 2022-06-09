
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_phoi_hop_khac/them_don_vi_phoi_hop_khac_widget.dart';
import 'package:ccvc_mobile/widgets/thong_tin_khach_moi_widget/them_thong_tin_khach_moi_widget.dart';
import 'package:flutter/material.dart';

class ThanhPhanThamGiaExpandWidget extends StatelessWidget {
  const ThanhPhanThamGiaExpandWidget({Key? key, required this.cubit}) : super(key: key);
  final TaoLichHopCubit cubit;
  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.thanh_phan_tham_gia,
                style: textNormalCustom(
                    color: titleColumn, fontSize: 16.0.textScale()),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.0.textScale(space: 10),
          ),
          ThanhPhanThamGiaWidget(
            isPhuongThucNhan: true,
            onChange: (value) {
              cubit.listThanhPhanThamGia.addAll(value);
            },
            phuongThucNhan: (value) {},
            isTaoHop: true,
          ),
          spaceH16,
          TitleChildWidget(
            title: S.current.don_vi_phoi_hop_khac,
            sizeTitle: 14,
            child: ThemDonViPhoiHopKhacWidget(
              onChange: (List<DonViModel> value) {
                cubit.listThanhPhanThamGia.addAll(value);
              },
            ),
          ),
          spaceH24,
          TitleChildWidget(
            title: S.current.khach_moi,
            sizeTitle: 14,
            child: ThemThongTinKhachMoiWidget(
              onChange: (List<DonViModel> value) {
                cubit.listThanhPhanThamGia.addAll(value);
              },
            ),
          ),
          spaceH20,
        ],
      ),
    );
  }
}
