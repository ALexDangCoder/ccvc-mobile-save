import 'package:ccvc_mobile/domain/model/lich_lam_viec/nhac_lai_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class NhacLaiWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const NhacLaiWidget({
    Key? key,
    required this.taoLichLamViecCubit,
  }) : super(key: key);

  @override
  _NhacLaiWidgetState createState() => _NhacLaiWidgetState();
}

class _NhacLaiWidgetState extends State<NhacLaiWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NhacLaiModel>>(
        stream: widget.taoLichLamViecCubit.nhacLai,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return SelectOnlyExpand(
            urlIcon: ImageAssets.icNotify,
            listSelect: data.map<String>((e) => e.title ?? '').toList(),
            value: widget.taoLichLamViecCubit.selectNhacLai.title ?? '',
            title: S.current.nhac_lich,
            onChange: (value) {
              widget.taoLichLamViecCubit.selectNhacLai.title =
                  data[value].title;
              widget.taoLichLamViecCubit.selectNhacLai.value =
                  data[value].value;
            },
          );
        });
  }
}
