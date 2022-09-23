import 'package:ccvc_mobile/domain/model/lich_lam_viec/nhac_lai_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/material.dart';

class NhacLaiWidget extends StatefulWidget {
  final CreateWorkCalCubit cubit;
  final bool isEdit;

  const NhacLaiWidget({
    Key? key,
    required this.cubit,
    this.isEdit = false,
  }) : super(key: key);

  @override
  _NhacLaiWidgetState createState() => _NhacLaiWidgetState();
}

class _NhacLaiWidgetState extends State<NhacLaiWidget> {
  @override
  Widget build(BuildContext context) {
    final _cubit = widget.cubit;
    return StreamBuilder<List<NhacLaiModel>>(
        stream: _cubit.nhacLai,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return SelectOnlyExpand(
            urlIcon: ImageAssets.icNotify,
            listSelect: data.map<String>((e) => e.title ?? '').toList(),
            title: S.current.nhac_lich,
            value: widget.isEdit
                ? (_cubit.scheduleReminder?.nhacLai() ?? '')
                : _cubit.selectNhacLai.title ?? '',
            onChange: (value) {
              _cubit.selectNhacLai.title = data[value].title;
              _cubit.selectNhacLai.value = data[value].value;
              if (widget.isEdit) {
                _cubit.scheduleReminder?.typeReminder = data[value].value;
              }
            },
            onChangeCollapse: true,
          );
        });
  }
}
