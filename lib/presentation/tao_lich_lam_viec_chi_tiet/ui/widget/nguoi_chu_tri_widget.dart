import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expand_model.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class NguoiChuTriWidget extends StatefulWidget {
  final TaoLichLamViecCubit cubit;

  const NguoiChuTriWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _NguoiChuTriWidgetState createState() => _NguoiChuTriWidgetState();
}

class _NguoiChuTriWidgetState extends State<NguoiChuTriWidget> {
  @override
  Widget build(BuildContext context) {
    final _cubit = widget.cubit;
    return StreamBuilder<List<NguoiChutriModel>>(
      stream: _cubit.nguoiChuTri,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return SelectOnlyExpandModel(
          onChange: (value) {
            _cubit.selectNguoiChuTri?.userId = data[value].userId;
            _cubit.selectNguoiChuTri?.donViId = data[value].donViId;
          },
          urlIcon: ImageAssets.icPeople,
          listSelect: data,
          userId:  _cubit.selectNguoiChuTri?.userId ?? '',
          value: _cubit.selectNguoiChuTri?.title() ?? '',
          title: S.current.nguoi_chu_tri,
          maxLine: 2,
        );
      },
    );
  }
}
