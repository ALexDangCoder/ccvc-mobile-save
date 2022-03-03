import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/fake_data_tao_lich.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/mobile/tao_lich_hop_mobile.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tablet/tao_lich_hop_tablet.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/thanh_phan_tham_gia_widget_expand.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/title_child_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';

import 'package:flutter/material.dart';

class TaoLichHopScreen extends StatefulWidget {
  const TaoLichHopScreen({Key? key}) : super(key: key);

  @override
  _TaoLichHopScreenState createState() => _TaoLichHopScreenState();
}

class _TaoLichHopScreenState extends State<TaoLichHopScreen> {
  final TaoLichHopCubit _cubit = TaoLichHopCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TaoLichHopCubit>(
      cubit: _cubit,
      child: screenDevice(
          mobileScreen: const TaoLichHopMobileScreen(),
          tabletScreen: const TaoLichHopMobileTabletScreen()),
    );
  }
}
