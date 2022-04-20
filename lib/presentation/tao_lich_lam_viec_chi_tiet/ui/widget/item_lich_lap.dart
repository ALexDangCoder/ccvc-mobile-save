import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/fake_data_tao_lich.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class LichLapWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  LichLapWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _LichLapWidgetState createState() => _LichLapWidgetState();
}

class _LichLapWidgetState extends State<LichLapWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LichLapModel>>(
        stream: widget.taoLichLamViecCubit.lichLap,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return SelectOnlyExpand(
            urlIcon: ImageAssets.icNhacLai,
            title: S.current.lich_lap,
            value: widget.taoLichLamViecCubit.selectLichLap.name ?? '',
            listSelect: data.map<String>((e) => e.name ?? '').toList(),
            onChange: (value) {
              widget.taoLichLamViecCubit.selectLichLap.id = data[value].id;
              if (data[value].id == 7) {
                widget.taoLichLamViecCubit.lichLapTuyChinhSubject.add(true);
              } else {
                widget.taoLichLamViecCubit.lichLapTuyChinhSubject.add(false);
              }

              if (data[value].id != 1) {
                widget.taoLichLamViecCubit.lichLapKhongLapLaiSubject.add(true);
              } else {
                widget.taoLichLamViecCubit.lichLapKhongLapLaiSubject.add(false);
              }
            },
          );
        });
  }
}
