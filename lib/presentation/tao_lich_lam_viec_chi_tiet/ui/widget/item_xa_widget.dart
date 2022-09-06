import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemXaWidget extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final bool isEdit;
  final String name;

  const ItemXaWidget({
    Key? key,
    required this.taoLichLamViecCubit,
    this.isEdit = false,
    this.name = '',
  }) : super(key: key);

  @override
  _ItemXaWidgetState createState() => _ItemXaWidgetState();
}

class _ItemXaWidgetState extends State<ItemXaWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WardModel>>(
      stream: widget.taoLichLamViecCubit.xaSelect,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <WardModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.wardModel?.tenXaPhuong =
                data[value].tenXaPhuong;
            widget.taoLichLamViecCubit.wardModel?.id = data[value].id;
          },
          urlIcon: ImageAssets.icViTri,
          listSelect: data.map((e) => e.tenXaPhuong ?? '').toList(),
          hintText: widget.isEdit ? '' : S.current.chon_xa,
          value: widget.isEdit ? widget.name : '',
          title: S.current.xa,
        );
      },
    );
  }
}
