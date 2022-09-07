import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class LinhVucWidget extends StatefulWidget {
  final CreateWorkCalCubit cubit;
  final bool isEdit;
  final String name;

  const LinhVucWidget({
    Key? key,
    required this.cubit,
    this.isEdit = false,
    this.name = '',
  }) : super(key: key);

  @override
  _LinhVucWidgetState createState() => _LinhVucWidgetState();
}

class _LinhVucWidgetState extends State<LinhVucWidget> {
  @override
  Widget build(BuildContext context) {
    final _cubit = widget.cubit;
    return StreamBuilder<List<LoaiSelectModel>>(
      stream: _cubit.linhVuc,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <LoaiSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            _cubit.selectLinhVuc?.id = data[value].id;
            _cubit.selectLinhVuc?.name = data[value].name;
          },
          urlIcon: ImageAssets.icWork,
          listSelect: data.map((e) => e.name).toList(),
          hintText: widget.isEdit ? '' : S.current.chon_linh_vuc,
          title: S.current.linh_vuc,
          value: widget.isEdit ? widget.name : _cubit.selectLinhVuc?.name ?? '',
        );
      },
    );
  }
}
