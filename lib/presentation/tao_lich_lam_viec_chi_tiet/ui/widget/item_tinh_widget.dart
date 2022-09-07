import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemTinhWidget extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final bool isEdit;
  final String name;

  const ItemTinhWidget({
    Key? key,
    required this.taoLichLamViecCubit,
    this.isEdit = false,
    this.name = '',
  }) : super(key: key);

  @override
  _ItemTinhWidgetState createState() => _ItemTinhWidgetState();
}

class _ItemTinhWidgetState extends State<ItemTinhWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TinhSelectModel>>(
      stream: widget.taoLichLamViecCubit.tinhSelect,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <TinhSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.tinhSelectModel?.tenTinhThanh =
                data[value].tenTinhThanh;
            widget.taoLichLamViecCubit.tinhSelectModel?.id = data[value].id;
            widget.taoLichLamViecCubit.getDataDistrict(data[value].id ?? '');
          },
          urlIcon: ImageAssets.icViTri,
          listSelect: data.map((e) => e.tenTinhThanh ?? '').toList(),
          hintText: widget.isEdit ? '' : S.current.chon_tinh,
          value: widget.isEdit ? widget.name : '',
          title: S.current.tinh,
        );
      },
    );
  }
}
