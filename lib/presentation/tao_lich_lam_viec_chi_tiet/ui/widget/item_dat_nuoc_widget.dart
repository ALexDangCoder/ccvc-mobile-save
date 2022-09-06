import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemDatNuocWidget extends StatefulWidget {
  final CreateWorkCalCubit cubit;
  final bool isEdit;
  final String name;

  const ItemDatNuocWidget({
    Key? key,
    required this.cubit,
    this.isEdit = false,
    this.name = '',
  }) : super(key: key);

  @override
  _ItemDatNuocWidgetState createState() => _ItemDatNuocWidgetState();
}

class _ItemDatNuocWidgetState extends State<ItemDatNuocWidget> {
  @override
  Widget build(BuildContext context) {
    final _cubit = widget.cubit;
    return StreamBuilder<List<DatNuocSelectModel>>(
      stream: _cubit.datNuocSelect,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <DatNuocSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            _cubit.datNuocSelectModel?.name = data[value].name;
            _cubit.datNuocSelectModel?.id = data[value].id;
            _cubit.selectedCountryID = data[value].id ?? '';
          },
          urlIcon: ImageAssets.icViTri,
          value: widget.isEdit ? widget.name : '',
          listSelect: data.map((e) => e.name ?? '').toList(),
          hintText: widget.isEdit ? '' : 'Chọn nước',
          title: S.current.quoc_gia,
        );
      },
    );
  }
}
