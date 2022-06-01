
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/chuyen_giong_noi_thanh_van_ban/ui/mobile/speech_to_text_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'icon_with_title_widget.dart';

class BocBangWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const BocBangWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _BocBangWidgetState createState() => _BocBangWidgetState();
}

class _BocBangWidgetState extends State<BocBangWidget> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        title: S.current.boc_bang,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              IconWithTiltleWidget(
                icon: ImageAssets.icDocument2,
                title: S.current.dich_truc_tuyen,
                onPress: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.dich_truc_tuyen,
                    child: const SpeechToTextMobile(),
                  );
                },
              ),
              const SizedBox(height: 20,),
              IconWithTiltleWidget(
                icon: ImageAssets.icShareFile,
                title: S.current.them_file_boc_bang,
                onPress: () {},
              ),
              const SizedBox(height: 20,),
              DoubleButtonBottom(
                title1: S.current.tham_du,
                title2: S.current.tu_choi,
                onPressed1: () {},
                onPressed2: () {},
              )
            ],
          ),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60, left: 13.5),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
