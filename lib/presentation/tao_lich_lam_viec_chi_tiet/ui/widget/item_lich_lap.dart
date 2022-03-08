import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
    return SelectOnlyExpand(
      urlIcon: ImageAssets.icNhacLai,
      title: S.current.lich_lap,
      value: FakeDataTaoLichHop.lichLap.first,
      listSelect: FakeDataTaoLichHop.lichLap,
    );
  }
}
