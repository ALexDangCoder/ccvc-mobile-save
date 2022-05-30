
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaiLichWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const LoaiLichWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _LoaiLichWidgetState createState() => _LoaiLichWidgetState();
}

class _LoaiLichWidgetState extends State<LoaiLichWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LoaiSelectModel>>(
      stream: widget.taoLichLamViecCubit.loaiLich,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return SelectOnlyExpand(
          onChange: (value) {
            widget.taoLichLamViecCubit.selectLoaiLichId = data[value].id;
            if (data[value].id == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
              widget.taoLichLamViecCubit.checkTrongNuoc.sink.add(true);
            } else {
              widget.taoLichLamViecCubit.checkTrongNuoc.sink.add(false);
            }
            widget.taoLichLamViecCubit.changeOption.sink.add(data[value].name);
          },
          urlIcon: ImageAssets.icCalendarUnFocus,
          value: widget.taoLichLamViecCubit.selectLoaiLich?.name ?? '',
          listSelect: data.map((e) => e.name).toList(),
          title: S.current.loai_lich,
        );
      },
    );
  }
}
