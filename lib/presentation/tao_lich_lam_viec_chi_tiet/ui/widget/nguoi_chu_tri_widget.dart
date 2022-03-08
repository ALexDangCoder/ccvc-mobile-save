import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class NguoiChuTriWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit ;

  const NguoiChuTriWidget({Key? key, required this.taoLichLamViecCubit}) : super(key: key);

  @override
  _NguoiChuTriWidgetState createState() => _NguoiChuTriWidgetState();
}

class _NguoiChuTriWidgetState extends State<NguoiChuTriWidget> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NguoiChutriModel>>(
      stream: widget.taoLichLamViecCubit.nguoiChuTri,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit
                .selectNguoiChuTri?.userId = data[value].userId;
            widget.taoLichLamViecCubit
                .selectNguoiChuTri?.donViId = data[value].donViId;
          },
          urlIcon: ImageAssets.icPeople,
          listSelect: data.map((e) => e.title()).toList(),
          value: widget.taoLichLamViecCubit.selectNguoiChuTri?.title() ?? '',
          title:  S.current.nguoi_chu_tri,
        );
      }
    );
  }
}
