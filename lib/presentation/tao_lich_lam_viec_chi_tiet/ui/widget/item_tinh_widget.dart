import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemTinhWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  ItemTinhWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

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
            widget.taoLichLamViecCubit.getDataHuyen(data[value].id ?? '');
          },
          urlIcon: ImageAssets.icViTri,
          listSelect: data.map((e) => e.tenTinhThanh ?? '').toList(),
          value: widget.taoLichLamViecCubit.tinhSelectModel?.tenTinhThanh ?? '',
          title: S.current.tinh,
        );
      },
    );
    return Container();
  }
}
