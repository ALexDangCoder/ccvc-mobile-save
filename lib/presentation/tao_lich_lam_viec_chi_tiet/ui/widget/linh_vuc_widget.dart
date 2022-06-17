import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class LinhVucWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  LinhVucWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _LinhVucWidgetState createState() => _LinhVucWidgetState();
}

class _LinhVucWidgetState extends State<LinhVucWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LoaiSelectModel>>(
      stream: widget.taoLichLamViecCubit.linhVuc,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <LoaiSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.selectLinhVuc?.id = data[value].id;
            widget.taoLichLamViecCubit.selectLinhVuc?.name = data[value].name;
          },
          urlIcon: ImageAssets.icWork,
          listSelect: data.map((e) => e.name).toList(),
          hintText: S.current.chon_linh_vuc,
          title: S.current.linh_vuc,
        );
      },
    );
  }
}
