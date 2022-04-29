import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemDatNuocWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  ItemDatNuocWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _ItemDatNuocWidgetState createState() => _ItemDatNuocWidgetState();
}

class _ItemDatNuocWidgetState extends State<ItemDatNuocWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DatNuocSelectModel>>(
      stream: widget.taoLichLamViecCubit.datNuocSelect,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <DatNuocSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.datNuocSelectModel?.name =
                data[value].name;
          },
          urlIcon: ImageAssets.icViTri,
          listSelect: data.map((e) => e.name ?? '').toList(),
          value: '',
          title: S.current.quoc_gia,
        );
      },
    );
    return Container();
  }
}
