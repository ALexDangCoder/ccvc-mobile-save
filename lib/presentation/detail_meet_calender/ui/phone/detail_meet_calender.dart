import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// todo chi tiet van ban
class DetailMeetCalenderScreen extends StatefulWidget {
  @override
  State<DetailMeetCalenderScreen> createState() =>
      _DetailMeetCalenderScreenState();
}

class _DetailMeetCalenderScreenState extends State<DetailMeetCalenderScreen> {
  late DetailMeetCalenderCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = DetailMeetCalenderCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: backgroundColorApp,
        bottomOpacity: 0.0,
        elevation: APP_DEVICE == DeviceType.MOBILE ? 0 : 0.7,
        shadowColor: bgDropDown,
        automaticallyImplyLeading: false,
        title: Text(
          S.current.chi_tiet_lich_hop,
          style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ),
      body: DetailMeetCalendarInherited(
        cubit: cubit,
        child: ExpandGroup(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: const [
                 CongTacChuanBiWidget(),
                 ThanhPhanThamGiaWidget(),
                 TaiLieuWidget(),
                 PhatBieuWidget(),
                 BieuQuyetWidget(),
                 KetLuanHopWidget(),
                 YKienCuocHopWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// void dowloadFile(YKienXuLyFileDinhKem file) {
//   // EasyLoading.show();
//
//   APICommon.shared.dowloadFile(file.Ten, file.Id).then((value) {
//     EasyLoading.dismiss(animation: true);
//
//     if (value.error != null) {
//       CoolAlert.show(
//         context: context,
//         type: CoolAlertType.error,
//         text: value.error,
//       );
//     } else {
//       CoolAlert.show(
//         context: context,
//         type: CoolAlertType.success,
//         text: value.data,
//       );
//     }
//   });
// }

}

// expand: openTab[index],
// onChangeExpand: () {
// final indexOpen = openTab
//     .indexWhere((element) => element == true);
// if (indexOpen >= 0) openTab[indexOpen] = false;
// if (indexOpen != index) {
// setState(() {
// openTab[index] = !openTab[index];
// });
// } else {
// setState(() {
// openTab[index] = false;
// });
// }
// },

class DetailMeetCalendarInherited extends InheritedWidget {
  DetailMeetCalenderCubit cubit;

  DetailMeetCalendarInherited(
      {Key? key, required this.cubit, required Widget child})
      : super(key: key, child: child);

  static DetailMeetCalendarInherited of(BuildContext context) {
    final DetailMeetCalendarInherited? result = context
        .dependOnInheritedWidgetOfExactType<DetailMeetCalendarInherited>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
