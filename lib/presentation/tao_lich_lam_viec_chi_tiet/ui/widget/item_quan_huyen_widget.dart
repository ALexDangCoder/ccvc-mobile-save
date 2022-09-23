import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemHuyenWidget extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final bool isEdit;
  final String name;

  const ItemHuyenWidget({
    Key? key,
    required this.taoLichLamViecCubit,
    this.isEdit = false,
    this.name = '',
  }) : super(key: key);

  @override
  _ItemHuyenWidgetState createState() => _ItemHuyenWidgetState();
}

class _ItemHuyenWidgetState extends State<ItemHuyenWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HuyenSelectModel>>(
      stream: widget.taoLichLamViecCubit.huyenSelect,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <HuyenSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.huyenSelectModel?.tenQuanHuyen =
                data[value].tenQuanHuyen;
            widget.taoLichLamViecCubit.huyenSelectModel?.id = data[value].id;
            widget.taoLichLamViecCubit.getDataWard(data[value].id ?? '');
          },
          urlIcon: ImageAssets.icViTri,
          listSelect: data.map((e) => e.tenQuanHuyen ?? '').toList(),
          hintText: widget.isEdit ? '' : S.current.chon_huyen,
          value: widget.isEdit ? widget.name : '',
          title: S.current.quan_huyen,
          onChangeCollapse: true,
        );
      },
    );
  }
}
