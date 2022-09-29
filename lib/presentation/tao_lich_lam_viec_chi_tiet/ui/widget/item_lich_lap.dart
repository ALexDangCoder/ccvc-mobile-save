import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class LichLapWidget extends StatefulWidget {
  final CreateWorkCalCubit cubit;
  final bool isEdit;

  const LichLapWidget({
    Key? key,
    required this.cubit,
    this.isEdit = false,
  }) : super(key: key);

  @override
  _LichLapWidgetState createState() => _LichLapWidgetState();
}

class _LichLapWidgetState extends State<LichLapWidget> {
  @override
  Widget build(BuildContext context) {
    final _cubit = widget.cubit;
    return StreamBuilder<List<LichLapModel>>(
      stream: _cubit.lichLap,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return SelectOnlyExpand(
          urlIcon: ImageAssets.icNhacLai,
          title: S.current.lich_lap,
          listSelect: data.map<String>((e) => e.name ?? '').toList(),
          value: widget.isEdit
              ? _cubit.detailCalendarWorkModel.lichLap()
              : _cubit.selectLichLap.name ?? '',
          onChange: (value) {
            _cubit.selectLichLap.id = data[value].id;
            if (data[value].id == 7) {
              _cubit.lichLapTuyChinhSubject.add(true);
            } else {
              _cubit.lichLapTuyChinhSubject.add(false);
            }

            if (data[value].id != 1) {
              _cubit.lichLapKhongLapLaiSubject.add(true);
            } else {
              _cubit.lichLapKhongLapLaiSubject.add(false);
            }
          },
          onChangeCollapse: true,
        );
      },
    );
  }
}
