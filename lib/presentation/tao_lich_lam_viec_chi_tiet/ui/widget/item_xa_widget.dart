import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class ItemXaWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  ItemXaWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _ItemXaWidgetState createState() => _ItemXaWidgetState();
}

class _ItemXaWidgetState extends State<ItemXaWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<XaSelectModel>>(
      stream: widget.taoLichLamViecCubit.xaSelect,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <XaSelectModel>[];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.xaSelectModel?.tenXaPhuong =
                data[value].tenXaPhuong;
          },
          urlIcon: ImageAssets.icViTri,
          listSelect: data.map((e) => e.tenXaPhuong ?? '').toList(),
          value: '',
          title: S.current.xa,
        );
      },
    );
    return Container();
  }
}
